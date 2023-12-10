import { Controller } from "@hotwired/stimulus"
import * as L from 'leaflet';
import tinycolor from 'tinycolor';

export default class extends Controller {
  connect() {
    const [countryCounts, max] = this.extractCountryCountsAndTotal()

    // setup leaflet dependencies
    this.geoJSONObj = null
    this.map = L.map(this.element.id).setView([51.505, -0.09], 2)

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: 'Map data © <a href="https://openstreetmap.org">OpenStreetMap</a> contributors',
    }).addTo(this.map)
    this.info = this.setupInfo()
    this.info.addTo(this.map)

    // took from: https://geojson-maps.ash.ms/
    fetch('/geo.json')
      .then(response => response.json())
      .then(geojson => {
        // ToDo: optimize this code 
        Object.entries(countryCounts).forEach(([countryIsoCode, counts]) => {
          geojson.features.forEach(feature => {
            if (feature.properties.iso_a2 === countryIsoCode) {
              feature.properties.counts = counts
            }
          })
        })

        this.geoJSONObj = L.geoJson(geojson, {
          // ToDo: make the color configurable
          style: this.mapStyle('#00008b', max),
          onEachFeature: this.onEachFeature
        }).addTo(this.map)
      })

  }

  extractCountryCountsAndTotal = () => {
    // setup countries count data
    let maxTotal = 1
    const countries = this.element.dataset.countries.split(",")
    const countryCounts = {}

    countries.forEach(country => {
      if (countryCounts[country]) {
       maxTotal = Math.max(maxTotal, countryCounts[country]++)
      } else {
        countryCounts[country] = 1
      }
    })

    return [countryCounts, maxTotal]
  }

  setupInfo = () => {
    const info = L.control();

    info.onAdd = function (_map) {
        this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
        this.update();
        return this._div;
    };
    
    // method that we will use to update the control based on feature properties passed
    const showVisits = (visitsCount) => {
      if (visitsCount > 0) {
        return `${visitsCount} visits`
      }

      return 'No visits'
    }
    info.update = function (props) {
        this._div.innerHTML = '<h4>Stats per country</h4>' +  (props ?
            `<b>${props.name}</b><br />${showVisits(props.counts)}`
            : 'Hover over a country');
    };

    return info;
  }

  mapStyle = (hexColor, maxCount) => (feature) => {
    return {
        fillColor: this.getColor(hexColor, maxCount, feature.properties.counts),
        weight: 2,
        opacity: 1,
        color: 'white',
        dashArray: '3',
        fillOpacity: 0.7
    }
  }

  getColor(hexColor, maxNumber, currentNumber) {
    if (isNaN(currentNumber)) {
      return '#eeeeee';
    }

    const differenceRatio = Math.max((maxNumber - currentNumber) / maxNumber, 0);
    const differencePercentage = Math.ceil(differenceRatio * 100);
  
    const stepPercentile = 20;
    const lighterPercentile = 10;
  
    const roundedLightnessPercentage = Math.ceil(differencePercentage / stepPercentile) * lighterPercentile;
  
    return tinycolor(hexColor).lighten(roundedLightnessPercentage).toHexString();
  }

  onEachFeature = (_feature, layer) => {
    layer.on({
        mouseover: this.highlightFeature,
        mouseout: this.resetHighlight,
    });
  }

  highlightFeature = (e) => {
    const layer = e.target;
    this.info.update(layer.feature.properties)

    layer.setStyle({
        weight: 2,
        color: '#666',
        dashArray: '',
        fillOpacity: 0.7
    });

    layer.bringToFront();
  }

  resetHighlight = (e) => {
    this.geoJSONObj.resetStyle(e.target);
    this.info.update()
  }

  disconnect() {
    this.geoJSONObj.remove()
    this.map.remove()
  }
}
