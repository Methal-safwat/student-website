const API_URL = 'http://localhost:3000/students';

function getStudents() {
  fetch(API_URL)
      .then(res => res.json())
      .then(data => {
        const tableBody = document.querySelector("#studentTable tbody");
        tableBody.innerHTML = "";
        data.forEach(student => {
          const row = document.createElement("tr");

          row.innerHTML = `
          <td>${student.id}</td>
          <td>${student.name}</td>
          <td>${student.age}</td>
          <td><button onclick="deleteStudent(${student.id})">Delete</button></td>
        `;

          tableBody.appendChild(row);
        });
      });
}


function addStudent() {
  const name = document.getElementById('name').value;
  const age = parseInt(document.getElementById('age').value);

  fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ name, age })
  }).then(() => {
    getStudents();
  });
}

function deleteStudent(id) {
  fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  }).then(() => {
    getStudents();
  });
}
