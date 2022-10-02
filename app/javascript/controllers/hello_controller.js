import { Controller } from "@hotwired/stimulus"
const ARRAY = []

export default class extends Controller {
  toggleToCart(e) {
    toggle(ARRAY, this.element.id);
    console.log(ARRAY);
  }
}

function toggle(array, value) {
  var index = array.indexOf(value);

  if (index === -1) {
      array.push(value);
  } else {
      array.splice(index, 1);
  }
}