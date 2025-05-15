import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets =["box"]
  connect() {
    this.element.addEventListener("modal:close", () => this.close())
  }

  open() {
    console.log("open called", this.boxTarget);
    this.boxTarget.classList.remove("hidden");
    this.boxTarget.style.display = "flex";
  }

  close() {
    console.log("close called");
    this.boxTarget.classList.add("hidden");
    this.boxTarget.style.display = "none";
  }
}
