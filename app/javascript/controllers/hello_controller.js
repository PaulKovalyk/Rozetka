import { Controller } from "@hotwired/stimulus"
const ARRAY = []
const DATA = [1,2,4]
let data = {
  product_ids: sessionStorage.getItem("product_ids").split(","),
  product : {
   title: "test",
   description: "test",
   price: 100
}
}
export default class extends Controller {
  toggleToCart(e) {
    toggle(ARRAY, this.element.id);
    console.log(ARRAY);
  }
  sendToCart(e) {
    console.log(data);
    send_ids(data);
  }
}




function toggle(array, value) {
  var index = array.indexOf(value);

  if (index === -1) {
      array.push(value);
      sessionStorage.setItem("product_ids", array)
  } else {
      array.splice(index, 1);
  }
}


function send_ids(DATA){
  const BASE_URL = window.location.origin;
  fetch (`${BASE_URL}`, {
    method: 'GET',
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
    },
    body: JSON.stringify(DATA)
})
}
