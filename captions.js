'use strict';

const readline = require('readline');
const fs = require('fs');

// make sure we got a filename on the command line.
if (process.argv.length < 3) {
  console.log('Usage: node ' + process.argv[1] + ' FILENAME');
  process.exit(1);
}

const rl = readline.createInterface({
  input: fs.createReadStream(process.argv[2])
});

const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

const milestones = [
  { timestamp: 1422248400, caption: `January 26, 2015: "Introducing Aurelia" blog post` },
  { timestamp: 1447650000, caption: `November 16, 2015: Beta Release Announced` },
  { timestamp: 1466568000, caption: `June 22, 2016: Release Candidate Announced` },
  { timestamp: 1469577600, caption: `July 27, 2016: Aurelia 1.0 Announced` },
];
let milestone = milestones.shift();
let captions = '';
const users = {};
let userCount = 0;
let timestamp
let user;
let date;
rl.on('line', line => {
  user = line.substr(11, line.indexOf('|', 12) - 11);
  if (user in users) {
    return;
  }
  userCount++;
  timestamp = +line.substr(0, 10);
  date = new Date(timestamp * 1000);
  users[user] = timestamp;
  if (userCount % 10 !== 0) {
    return;
  }
  if (milestone && milestone.timestamp < timestamp) {
    captions += `${milestone.timestamp}|${milestone.caption}\n`;
    milestone = milestones.shift();
  }
  captions += `${timestamp}|${monthNames[date.getMonth()]} ${date.getDate()}, ${date.getFullYear()}: ${userCount} contributors\n`;
});

rl.on('close', () => {
  fs.writeFile('captions.txt', captions, err => {
    if (err) {
      throw err;
    }
    console.log('done.');
  });
});
