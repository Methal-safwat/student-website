
-- Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL
);

-- Doctors Table
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialization VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Patients Table
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    gender ENUM('Male', 'Female', 'Other'),
    DOB DATE,
    contact VARCHAR(20)
);

-- Appointments Table
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT,
    patient_id INT,
    date DATE,
    time TIME,
    reason VARCHAR(255),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Treatments Table
CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    description TEXT,
    treatment_date DATE,
    doctor_id INT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Sample Data
INSERT INTO departments (dept_name) VALUES 
('Cardiology'), ('Neurology'), ('Orthopedics'), ('Pediatrics');

INSERT INTO doctors (name, specialization, email, dept_id) VALUES
('Dr. Ali Omar', 'Cardiologist', 'ali.omar@hospital.com', 1),
('Dr. Sara Nabil', 'Neurologist', 'sara.nabil@hospital.com', 2),
('Dr. Hani Fawzy', 'Orthopedic Surgeon', 'hani.fawzy@hospital.com', 3),
('Dr. Mona Salem', 'Pediatrician', 'mona.salem@hospital.com', 4);

INSERT INTO patients (name, gender, DOB, contact) VALUES
('Ahmed Mohamed', 'Male', '1990-03-15', '0551234567'),
('Laila Youssef', 'Female', '1985-07-22', '0552345678'),
('Karim Adel', 'Male', '2000-11-01', '0553456789'),
('Noha Said', 'Female', '1995-04-10', '0554567890');

INSERT INTO appointments (doctor_id, patient_id, date, time, reason) VALUES
(1, 1, '2025-05-10', '09:00:00', 'Chest pain'),
(2, 2, '2025-05-11', '11:00:00', 'Migraine'),
(4, 4, '2025-05-12', '10:30:00', 'Child fever');

INSERT INTO treatments (patient_id, description, treatment_date, doctor_id) VALUES
(1, 'Prescribed heart medication', '2025-05-10', 1),
(2, 'MRI scan and medication', '2025-05-11', 2),
(4, 'Fever reducer prescribed', '2025-05-12', 4);



-- 1. List all patients and their assigned doctor names
SELECT p.name AS patient, d.name AS doctor
FROM appointments a
         JOIN patients p ON a.patient_id = p.patient_id
         JOIN doctors d ON a.doctor_id = d.doctor_id;

-- 2. Number of appointments per department
SELECT dept_name, COUNT(*) AS total_appointments
FROM appointments a
         JOIN doctors d ON a.doctor_id = d.doctor_id
         JOIN departments dp ON d.dept_id = dp.dept_id
GROUP BY dept_name;

-- 3. Show all treatments given to a patient
SELECT p.name AS patient, t.description, t.treatment_date
FROM treatments t
         JOIN patients p ON t.patient_id = p.patient_id
WHERE p.name = 'Ahmed Mohamed';

-- 4. Upcoming appointments for a specific doctor
SELECT a.date, a.time, p.name AS patient
FROM appointments a
         JOIN patients p ON a.patient_id = p.patient_id
WHERE a.doctor_id = 1
ORDER BY a.date, a.time;
