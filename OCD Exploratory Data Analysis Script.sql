--1. How many patients are in the dataset?
SELECT COUNT(DISTINCT([Patient ID])) AS Total_Patients
FROM PATIENT_DATA;

--2.What is the  percentage distribution of patients by gender?
SELECT GENDER, 
COUNT(GENDER) AS DISTRIBUTION,
ROUND((COUNT(GENDER) * 100.0) / (SELECT COUNT(*) FROM PATIENT_DATA), 2) AS Percentage_Distribution
FROM PATIENT_DATA
GROUP BY GENDER;

--3.What is the average age of patients?
SELECT AVG(CAST([Age] AS INT)) AS AVG_AGE
FROM PATIENT_DATA;

--4.How many patients belong to each ethnicity?
SELECT [Ethnicity], COUNT(DISTINCT([Patient ID])) AS Total_Patients
FROM PATIENT_DATA
GROUP BY [Ethnicity]
ORDER BY Total_Patients DESC;

--5. How many patients have a family history of OCD?
SELECT COUNT([Patient ID]) AS Family_History_of_OCD
FROM PATIENT_DATA  
WHERE [Family History of OCD]= 'yes'

--6. What is the distribution of obsession types and compulsion types?
SELECT [Obsession Type], COUNT([Obsession Type]) AS Distribution
FROM Patient_Data
GROUP BY [Obsession Type]
ORDER BY Distribution DESC;

--6B. 
SELECT [Compulsion Type], COUNT([Compulsion Type]) AS Distribution
FROM Patient_Data
GROUP BY ([Compulsion Type])
ORDER BY Distribution DESC;

--7. What are the average Y-BOCS scores for obsessions and compulsions by gender?

SELECT 
  CASE 
    WHEN GENDER = 'Male' THEN 'Male'
    WHEN GENDER = 'Female' THEN 'Female'
   END AS Gender_Group,

  COUNT(GENDER) AS Gender_Count,
  ROUND(AVG([Y-BOCS Score (Obsessions)]), 2) AS Obsession_score,
  ROUND(AVG([Y-BOCS Score (Compulsions)]), 2) AS Compulsion_score
FROM PATIENT_DATA
GROUP BY 
  CASE 
    WHEN GENDER = 'Male' THEN 'Male'
    WHEN GENDER = 'Female' THEN 'Female'
   END;

--8.How many patients have been diagnosed with depression or anxiety?
SELECT
SUM(CASE WHEN [Anxiety Diagnosis]= 'YES' THEN 1 ELSE 0 END) AS Anxiety_count,
SUM(CASE WHEN [Depression Diagnosis]= 'YES' THEN 1 ELSE 0 END) AS Depression_count
FROM PATIENT_DATA


--9. What is the most prescribed medication?
SELECT MEDICATIONS, COUNT(MEDICATIONS) AS TOTAL_MEDICATIONS
FROM PATIENT_DATA
GROUP BY MEDICATIONS
ORDER BY TOTAL_MEDICATIONS DESC


--10 Total Number of  patients with both Anxiety and depression?
SELECT COUNT([Patient ID]) AS 'TOTAL_CO-DIAGNOSIS'
FROM Patient_Data
WHERE [Depression Diagnosis] = 'YES' AND [Anxiety Diagnosis]= 'YES'


--11. what is the most common compulsion and its respective average score
SELECT [Compulsion Type], COUNT ([Compulsion Type]) AS Distro,
ROUND(AVG([Y-BOCS Score (Compulsions)]), 2) AS Avg_score
FROM Patient_Data
GROUP BY [Compulsion Type] 
ORDER BY Distro DESC;


SELECT [Patient ID]
FROM patient_data
WHERE [Patient ID]=1018

SELECT *
FROM PATIENT_DATA
WHERE [Duration of Symptoms (months)] != 203

SELECT [Patient ID], AGE, [Marital Status], 
       TRY_CAST([OCD Diagnosis Date] AS date) AS DX_DATE
FROM PATIENT_DATA
WHERE TRY_CAST([OCD Diagnosis Date] AS DATE) > '2022-01-01'
AND [Marital Status]= 'MARRIED';

SELECT [Ethnicity], AVG(CAST(AGE AS INT)) AS AVG_AGE, COUNT(AGE), MAX(AGE) AS 'MAXI', MIN(AGE) AS 'MINI'
FROM PATIENT_DATA
GROUP BY [Ethnicity]
HAVING AVG(CAST(AGE AS INT))<47


SELECT TOP 2[Education Level], COUNT(AGE) AS CNT
FROM PATIENT_DATA
WHERE [Previous Diagnoses] = 'MDD'
GROUP BY [Education Level]
ORDER BY CNT ASC;

SELECT [Patient ID], [Y-BOCS Score (Compulsions)], Medications, 'NONE' AS 'QUERY DIAGNOSIS'
FROM PATIENT_DATA
WHERE Medications= 'NONE'


SELECT Medications, LEN('medications') AS LENGHT
FROM patient_data
GROUP BY Medications



 
 SELECT SUBSTRING([OCD Diagnosis Date],4,2) AS BIRTH_MONTH
 FROM patient_data

 SELECT TOP 1*
 FROM patient_data

SELECT [Obsession Type], [Compulsion Type], 
       CONCAT([Obsession Type], ' and ', [Compulsion Type]) AS SYMPTOMS
FROM PATIENT_DATA;

SELECT [Patient ID], [Age],
CASE 
    WHEN AGE BETWEEN 18 AND 24 THEN 'YOUTH'
    WHEN AGE BETWEEN 25 AND 34 THEN 'YOUNG ADULT'
    WHEN AGE BETWEEN 35 AND 44 THEN 'MIDDLE AGE'
    WHEN AGE BETWEEN 45 AND 54 THEN 'PRE-SENIOR'
    WHEN AGE BETWEEN 55 AND 64 THEN 'SENIOR'
    WHEN AGE > 64 THEN 'ELDER'
END AS [AGE GROUP]
FROM patient_data
ORDER BY [Age], [AGE GROUP];





