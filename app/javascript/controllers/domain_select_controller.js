import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleChange(event) {
    const selectedValue = event.currentTarget.value
    document.getElementById('currentDomain').innerHTML = selectedValue
  }
}
