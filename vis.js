div.replaceChildren()
div.style.position = 'relative';

white_url = 'https://em-content.zobj.net/thumbs/160/apple/81/medium-white-circle_26aa.png'
black_url = 'https://em-content.zobj.net/thumbs/160/apple/81/medium-black-circle_26ab.png'

// Create the first img element
const img1 = document.createElement('img');
img1.src = 'https://www.bytedance.ai/pic/board.jpg';
img1.style.position = 'absolute';
img1.style.top = '0';
img1.style.left = '0';
img1.style.width = '500px';  // Set the width of img1 to 100 pixels
img1.style.height = '500px';
div.appendChild(img1);

// Create the second img element
const img2 = document.createElement('img');
img2.src = black_url;
img2.style.position = 'absolute';
img2.style.width = '28px';  // Set the width of img2 to 100 pixels
img2.style.height = '28px'; // Set the height of img2 to 100 pixels

const result = Forge.run(Board.position);



// // Loop to create multiple img2 elements at specific coordinates
// for (let i = 0; i < 14; i++) {
//     for (let j = 0; j < 14; j++) {
//         const img2Copy = img2.cloneNode(true); // Create a copy of img2 element
//         img2Copy.style.top = `${24 + (i * 32.5)}px`; // Set the top property based on index
//         img2Copy.style.left = `${24 + (j * 32.5)}px`; // Set the left property based on index
//         div.appendChild(img2Copy); // Add the img2 element to the div element     
//     }
// }






