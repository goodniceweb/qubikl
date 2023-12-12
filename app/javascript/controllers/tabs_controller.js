import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"];

  connect() {
    this.showTab(0);
  }

  handleClick(event) {
    event.preventDefault();
    const index = event.currentTarget.dataset.index;
    this.showTab(index);
  }

  showTab(index) {
    this.tabTargets.forEach((tab) => {
      tab.classList.remove("is-active");
    });

    this.panelTargets.forEach((panel) => {
      panel.classList.remove("is-active");
      panel.classList.add("is-hidden");
    });

    this.tabTargets[index].classList.add("is-active");
    this.panelTargets[index].classList.remove("is-hidden");
    this.panelTargets[index].classList.add("is-active");
  }
}
