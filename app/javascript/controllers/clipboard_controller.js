import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleClick(_event) {
    const { content } = this.element.dataset
    if (content) {
      navigator.clipboard.writeText(content)
    }
  }
}
