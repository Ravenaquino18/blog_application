import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  recalculate(event) {
    const form = this.element;
    const amount = form.querySelector("[name='post[amount]']");
    const termMonths = form.querySelector("[name='post[term_months]']");
    if (!amount || !termMonths) return;

    const url = `/posts/loan_calculation?post[amount]=${amount.value}&post[term_months]=${termMonths.value}`;
    Turbo.visit(url, { frame: "loan_calculations", action: "replace" });
  }
}