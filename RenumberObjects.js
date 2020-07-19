const execSync = require('child_process').execSync;
const fs = require('fs');

if (!process.argv[2]) {
  console.log(`Run with node ${process.argv[1]} <start_number> <offset?> <end_number?>`);
  return;
}

const sourceNumber = Number(process.argv[2]);
let startNumber = 0;
let offset = 0;
let endNumber = null;
let highestId = 0;
if (process.argv[3]) {
  startNumber = sourceNumber;
  offset = Number(process.argv[3]);
}
if (process.argv[4]) {
  endNumber = Number(process.argv[4]);
}

console.log('Reading object files');
const objectFileList = execSync('ls objects/').toString().split('\n');
const objectFileNames = [];
const objectFileContents = [];

if (!process.argv[3]) {
  for (const file of objectFileList) {
    if (!file || isNaN(parseInt(file[0]))) {
      continue;
    }
    const fileContent = fs.readFileSync(`objects/${file}`).toString();
    const id = fileContent.match(/id=(\d+)?\r?\n/);
    if (Number(id[1]) + 1 < sourceNumber) {
      startNumber = Math.max( startNumber, Number(id[1]) + 1 );
    }
  }
  offset = startNumber - sourceNumber;
}

for (const file of objectFileList) {
  if (!file || isNaN(parseInt(file[0]))) {
    continue;
  }
  const fileContent = fs.readFileSync(`objects/${file}`).toString();
  const id = fileContent.match(/id=(\d+)?\r?\n/);
  if (Number(id[1]) >= startNumber && (endNumber === null || Number(id[1]) <= endNumber)) {
    objectFileNames.push(file.replace(id[1], Number(id[1]) + offset));
    objectFileContents.push(fileContent.replace(`id=${id[1]}`, `id=${Number(id[1]) + offset}`));
    execSync(`rm objects/${file}`);
  }
  highestId = Math.max( highestId, Number(id[1]) + offset);
}

console.log('Writing object files');
for (let i = 0; i < objectFileNames.length; i++) {
  fs.writeFileSync(`objects/${objectFileNames[i]}`, objectFileContents[i]);
}
if (process.argv[3]) {
  fs.writeFileSync(`objects/nextObjectNumber.txt`, highestId + 1);
} else {
  fs.writeFileSync(`objects/nextObjectNumber.txt`, sourceNumber);
}

console.log('Reading category files');
const categoryFileList = execSync('ls categories/').toString().split('\n');
const categoryFileNames = [];
const categoryFileContents = [];

for (const file of categoryFileList) {
  let needsReplacing = false;
  if (!file || isNaN(parseInt(file[0]))) {
    continue;
  }
  let fileContent = fs.readFileSync(`categories/${file}`).toString();
  const id = fileContent.match(/parentID=(\d+)?\r?\n/);
  let newFileName;
  if (Number(id[1]) >= startNumber && (endNumber === null || Number(id[1]) <= endNumber)) {
    needsReplacing = true;
    newFileName = file.replace(id[1], Number(id[1]) + offset);
    fileContent = fileContent.replace(`parentID=${id[1]}`, `parentID=${Number(id[1]) + offset}`)
  } else {
    newFileName = `${id[1]}.txt`;
  }
  const categoryMembers = fileContent.match(/\r?\n\d*/g);
  for (const member of categoryMembers) {
    const idMatch = member.match(/\r?\n(\d+)/);
    if (idMatch && Number(idMatch[1]) > startNumber && (endNumber === null || Number(idMatch[1]) <= endNumber)) {
      needsReplacing = true;
      fileContent = fileContent.replace(`\n${idMatch[1]}`, `\n${Number(idMatch[1]) + offset}`);
    }
  }

  if (needsReplacing) {
    categoryFileNames.push(newFileName);
    categoryFileContents.push(fileContent);
    execSync(`rm categories/${file}`);
  }
}

console.log('Writing category files');
for (let i = 0; i < categoryFileNames.length; i++) {
  fs.writeFileSync(`categories/${categoryFileNames[i]}`, categoryFileContents[i]);
}

console.log('Reading transition files');
const transitionFileList = execSync('ls transitions').toString().split('\n');
const transitionFileNames = [];
const transitionFileContents = [];

for (const file of transitionFileList) {
  if (!file || file.match(/fcz/)) {
    continue;
  }
  let needsReplacing = false;
  let fileName = file;
  let fileContent = fs.readFileSync(`transitions/${file}`).toString();
  const actor = file.match(/([^_]+)?_/)[1];
  const target = file.match(/[^_]+_([^_]+)?[_|\.]/)[1];
  if (actor == target && Number(actor) >= startNumber && (endNumber === null || Number(actor) <= endNumber)) {
    needsReplacing = true;
    fileName = fileName.replace(new RegExp(actor, 'g'), Number(actor) + offset);
  } else {
    if (Number(actor) >= startNumber && (endNumber === null || Number(actor) <= endNumber)) {
      needsReplacing = true;
      fileName = fileName.replace(actor, Number(actor) + offset);
    }
    if (Number(target) >= startNumber && (endNumber === null || Number(target) <= endNumber)) {
      needsReplacing = true;
      fileName = fileName.replace(target, Number(target) + offset);
    }
  }
  const newActor = fileContent.match(/(\d+)? /)[1];
  if (Number(newActor) >= startNumber && (endNumber === null || Number(newActor) <= endNumber)) {
    needsReplacing = true;
    fileContent = fileContent.replace(`${newActor} `, `${Number(newActor) + offset} `);
  }
  const newTarget = fileContent.match(/\d+ (\d+)? /)[1];
  if (Number(newTarget) >= startNumber && (endNumber === null || Number(newTarget) <= endNumber)) {
    needsReplacing = true;
    fileContent = fileContent.replace(`${newTarget} `, `${Number(newTarget) + offset} `);
  }

  if (needsReplacing) {
    transitionFileNames.push(fileName);
    transitionFileContents.push(fileContent);
    execSync(`rm transitions/${file}`);
  }
}

console.log('Writing transition files');
for (let i = 0; i < transitionFileNames.length; i++) {
  fs.writeFileSync(`transitions/${transitionFileNames[i]}`, transitionFileContents[i]);
}

console.log('Reading animation files');
const animationFileList = execSync('ls animations').toString().split('\n');
const animationFileNames = [];
const animationFileContents = [];

for (const file of animationFileList) {
  if (!file || isNaN(parseInt(file[0]))) {
    continue;
  }
  const fileContent = fs.readFileSync(`animations/${file}`).toString();
  const id = fileContent.match(/id=(\d+)?\r?\n/);
  if (Number(id[1]) >= startNumber && (endNumber === null || Number(id[1]) <= endNumber)) {
    animationFileNames.push(file.replace(id[1], Number(id[1]) + offset));
    animationFileContents.push(fileContent.replace(`id=${id[1]}`, `id=${Number(id[1]) + offset}`));
    execSync(`rm animations/${file}`);
  }
}

console.log('Writing animation files');
for (let i = 0; i < animationFileNames.length; i++) {
  fs.writeFileSync(`animations/${animationFileNames[i]}`, animationFileContents[i]);
}
