-- CSDL QuanLySinhVien
-- Chay file nay tren MySQL Workbench.
-- CHECK duoc MySQL thuc thi tu phien ban 8.0.16 tro len.

CREATE DATABASE IF NOT EXISTS QuanLySinhVien
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE QuanLySinhVien;

-- Bang lop hoc
CREATE TABLE IF NOT EXISTS Class (
    ClassID INT NOT NULL AUTO_INCREMENT,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT,
    CONSTRAINT PK_Class PRIMARY KEY (ClassID)
) ENGINE=InnoDB;

-- Moi sinh vien thuoc mot lop; mot lop co the co nhieu sinh vien.
CREATE TABLE IF NOT EXISTS Student (
    StudentID INT NOT NULL AUTO_INCREMENT,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassID INT NOT NULL,
    CONSTRAINT PK_Student PRIMARY KEY (StudentID),
    CONSTRAINT FK_Student_Class FOREIGN KEY (ClassID)
        REFERENCES Class (ClassID)
) ENGINE=InnoDB;

-- Tin chi mac dinh la 1 va khong duoc nho hon 1.
CREATE TABLE IF NOT EXISTS Subject (
    SubID INT NOT NULL AUTO_INCREMENT,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1,
    Status BIT DEFAULT 1,
    CONSTRAINT PK_Subject PRIMARY KEY (SubID),
    CONSTRAINT CK_Subject_Credit CHECK (Credit >= 1)
) ENGINE=InnoDB;

-- Moi sinh vien chi co mot ban ghi diem cho mot mon hoc theo de bai.
CREATE TABLE IF NOT EXISTS Mark (
    MarkID INT NOT NULL AUTO_INCREMENT,
    SubID INT NOT NULL,
    StudentID INT NOT NULL,
    Mark FLOAT DEFAULT 0,
    ExamTimes TINYINT DEFAULT 1,
    CONSTRAINT PK_Mark PRIMARY KEY (MarkID),
    CONSTRAINT UQ_Mark_Subject_Student UNIQUE (SubID, StudentID),
    CONSTRAINT CK_Mark_Range CHECK (Mark BETWEEN 0 AND 100),
    CONSTRAINT FK_Mark_Subject FOREIGN KEY (SubID)
        REFERENCES Subject (SubID),
    CONSTRAINT FK_Mark_Student FOREIGN KEY (StudentID)
        REFERENCES Student (StudentID)
) ENGINE=InnoDB;

-- Kiem tra bang va cac cot sau khi tao.
SHOW TABLES;
DESCRIBE Class;
DESCRIBE Student;
DESCRIBE Subject;
DESCRIBE Mark;
