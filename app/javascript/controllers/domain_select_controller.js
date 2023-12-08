import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleChange(event) {
    const selectedValue = event.target.value
    document.getElementById('currentDomain').innerHTML = selectedValue
  }
}
