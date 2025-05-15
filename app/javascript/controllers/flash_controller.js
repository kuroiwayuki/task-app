import { Controller } from "@hotwired/stimulus";

// Flashメッセージを一定時間でフェードアウトし、自動的に削除する
export default class extends Controller {
  static values = {
    timeout: { type: Number, default: 5000 }, // デフォルト5秒
  };

  connect() {
    // 指定された時間後にフェードアウト
    setTimeout(() => {
      this.element.classList.add("opacity-0"); // CSSでフェード用のtransitionがある前提
      // 完全にフェードアウトした後にDOMから削除（0.7秒後）
      setTimeout(() => this.element.remove(), 700);
    }, this.timeoutValue);
  }
}
