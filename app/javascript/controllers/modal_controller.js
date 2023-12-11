import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  open(_event) {
    const { modalId } = this.element.dataset
    document.getElementById(modalId).classList.add('is-active')
  }

  close(_event) {
    const { modalId } = this.element.dataset
    document.getElementById(modalId).classList.remove('is-active')
  }
}
