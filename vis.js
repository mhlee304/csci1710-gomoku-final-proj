div.replaceChildren()
div.style.position = 'relative';

white_url = 'https://em-content.zobj.net/thumbs/160/apple/81/medium-white-circle_26aa.png'
black_url = 'https://em-content.zobj.net/thumbs/160/apple/81/medium-black-circle_26ab.png'

// Create the first img element
const board = document.createElement('img');
board.src = 'https://www.bytedance.ai/pic/board.jpg';
board.style.position = 'absolute';
board.style.top = '0';
board.style.left = '0';
board.style.width = '500px';  // Set the width of img1 to 100 pixels
board.style.height = '500px';
div.appendChild(board);


// Create the second img element
const white = document.createElement('img');
white.src = white_url;
white.style.position = 'absolute';
white.style.width = '28px';  // Set the width of img2 to 100 pixels
white.style.height = '28px'; // Set the height of img2 to 100 pixels

const black = document.createElement('img');
black.src = black_url;
black.style.position = 'absolute';
black.style.width = '28px';  // Set the width of img2 to 100 pixels
black.style.height = '28px'; // Set the height of img2 to 100 pixels

function makeBoard(stateAtom) {
    for (i = 0; i <= 14; i++) {
        for (j = 0; j <= 14; j++) {
            const val = stateAtom.position[i][j].toString().substring(0,1)
            if (val == "B") {
                const black_copy = black.cloneNode(true);
                black_copy.style.top = `${24 + (i * 32.5)}px`; // Set the top property based on index
                black_copy.style.left = `${24 + (j * 32.5)}px`; // Set the left property based on index
                div.appendChild(black_copy);
            } else if (val == "W") {
                const white_copy = white.cloneNode(true);
                white_copy.style.top = `${24 + (i * 32.5)}px`; // Set the top property based on index
                white_copy.style.left = `${24 + (j * 32.5)}px`; // Set the left property based on index
                div.appendChild(white_copy);
            }
        }
    }
}

makeBoard(Board.atom("Board0"))