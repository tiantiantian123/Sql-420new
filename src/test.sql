USE scott;
# 1. 查找部门30中员工的详细信息。
SELECT *
FROM emp;
# 2. 找出从事clerk工作的员工的编号、姓名、部门号。
SELECT
  EMPNO,
  ENAME,
  MGR
FROM emp
WHERE JOB = 'clerk';
# 3. 检索出奖金多于基本工资的员工信息。
SELECT *
FROM emp
WHERE COMM > emp.SAL;
# 4. 检索出奖金多于基本工资60%的员工信息。
SELECT *
FROM emp
WHERE COMM > emp.SAL * 0.6;
# 5. 希望看到10部门的经理或者20部门的职员(clerk)的信息。
SELECT *
FROM emp
WHERE (DEPTNO = 10 OR DEPTNO = 20) AND emp.JOB = 'clerk';
# 6. 找出10部门的经理、20部门的职员或者既不是经理也不是职员但是高于2000元的员工信息。
SELECT *
FROM emp
WHERE (DEPTNO = 10 AND JOB = 'manager') OR (DEPTNO = 20 AND JOB = 'clerk') OR
      (JOB != 'manager' AND JOB != 'clerk' AND SAL + ifnull(COMM, 0) > 2000);
# 7. 找出获得奖金的员工的工作。
SELECT
  EMPNO,
  ENAME,
  JOB
FROM emp
WHERE COMM IS NOT NULL;
# 8. 找出奖金少于100或者没有获得奖金的员工的信息。
SELECT *
FROM emp
WHERE (COMM < 100) OR (COMM = 0);
# 9. 查找员工雇佣日期中当月的最后一天雇佣的。
# select count(*) from emp
# where Convert(varchar(10),[%-%-30],120)=" + happen.toShortDateString（）
SELECT *
FROM emp
WHERE
  (day(HIREDATE) = 30 AND (month(HIREDATE) = 4 OR month(HIREDATE) = 6 OR month(HIREDATE) = 9 OR month(HIREDATE) = 11))
  OR
  (day(HIREDATE) = 31 AND (month(HIREDATE) = 1 OR month(HIREDATE) = 3 OR month(HIREDATE) = 5 OR month(HIREDATE) = 7) OR
   month(HIREDATE = 8) OR month(HIREDATE = 10) OR month(HIREDATE = 12))
  OR (day(HIREDATE) = 28 AND month(HIREDATE) = 2);
# 10. 检索出雇佣年限超过12年的员工信息。
SELECT *
FROM emp
WHERE 2016 - year(HIREDATE) > 12;
# 11. 找出姓名以A、B、S开始的员工信息。
SELECT *
FROM emp
WHERE (ENAME LIKE 'A%') OR (ENAME LIKE 'B%') OR (ENAME LIKE 'S%');
# 12. 找到名字长度为7个字符的员工信息。
SELECT *
FROM emp
WHERE length(ENAME) = 6;
# 13. 名字中不包含R字符的员工信息。
SELECT *
FROM emp
WHERE ENAME NOT LIKE '%R%';
# 14. 找出员工名字的前3个字符。
SELECT left(ENAME, 3)
FROM emp;
# 15. 将名字中A改为a。
SET @ename = '';
UPDATE emp
SET @ename = substr(ENAME, 0, 1)
WHERE ENAME = 'A' + @name1;

# 16. 将员工的雇佣日期拖后10年。
UPDATE emp
SET HIREDATE = HIREDATE + 100000;
# 17. 返回员工的详细信息并按姓名排序。
SELECT *
FROM emp
ORDER BY ENAME;
# 18. 返回员工的信息并按员工的工作年限降序排列。
SELECT *
FROM emp
ORDER BY HIREDATE ASC;
# 19. 返回员工的信息并按工作降序工资升序排列。
SELECT *
FROM emp
ORDER BY JOB DESC, SAL ASC;
# 20. 返回员工的姓名、雇佣年份和月份并且按月份和雇佣日期排序。
SELECT
  ENAME,
  year(HIREDATE)  AS HIREYEAR,
  month(HIREDATE) AS HIREMONTH
FROM emp
ORDER BY HIREMONTH, HIREDATE;
# 21. 计算员工的日薪(按30天)。
SELECT
  ENAME,
  SAL / 30 AS DAYSAL
FROM emp;
# 22. 找出2月份雇佣的员工。
SELECT
  ENAME,
  month(HIREDATE) AS HIREMONTH
FROM emp
WHERE month(HIREDATE) = 2;
# 23. 至今为止，员工被雇佣的天数。
SELECT
  ENAME,
  ((2016 - year(HIREDATE)) * 365 - dayofyear(HIREDATE) + 112) AS HIREDAYS
FROM emp;
# 24. 找出姓名中包含A的员工信息。
SELECT *
FROM emp
WHERE ENAME LIKE '%A%';
# 25. 计算出员工被雇佣了多少年、多少月、多少日。
SELECT
  ENAME,
  (2016 - year(HIREDATE))                                        HIREYEARS,
  ((2016 - year(HIREDATE)) * 12 - month(HIREDATE) + 4)           HIREMONTHS,
  ((2016 - year(HIREDATE)) * 365 - dayofyear(HIREDATE) + 112) AS HIREDAYS
FROM emp;

# 1. 返回拥有员工的部门名、部门号。
SELECT
  d.DEPTNO,
  d.DNAME
FROM dept d JOIN emp e
    ON d.DEPTNO = e.DEPTNO;
# 2. 工资水平多于smith的员工信息。
SELECT *
FROM emp
WHERE emp.SAL > (SELECT SAL
                 FROM emp
                 WHERE ENAME = 'scott');
# 3. 返回员工和所属经理的姓名。
SELECT
  a.ENAME clerkname,
  b.ENAME managername
FROM emp a, emp b
WHERE (a.JOB != 'manager') AND (b.JOB = 'manager') AND (a.DEPTNO = b.DEPTNO);
# 4. 返回雇员的雇佣日期早于其经理雇佣日期的员工及其经理姓名。
SELECT
  a.ENAME clerkname,
  b.ENAME managername
FROM emp a, emp b
WHERE (a.JOB != 'manager') AND (b.JOB = 'manager') AND (a.DEPTNO = b.DEPTNO) AND (a.HIREDATE > b.HIREDATE);
# 5. 返回员工姓名及其所在的部门名称。
SELECT
  e.ENAME,
  d.DNAME
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO;
# 6. 返回从事clerk工作的员工姓名和所在部门名称。
SELECT
  e.ENAME,
  d.DNAME
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO
WHERE e.JOB = 'clerk';
# 7. 返回部门号及其本部门的最低工资。
SELECT
  DEPTNO,
  LOSAL
FROM dept d JOIN salgrade s;
# 8. 返回销售部sales所有员工的姓名。
SELECT ENAME
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO
WHERE e.JOB = 'salesman';
# 9. 返回工资水平多于平均工资的员工。
SELECT
  e.EMPNO,
  e.ENAME
FROM emp e
WHERE sal > (SELECT avg(sal)
             FROM emp);
# 10. 返回与SCOTT从事相同工作的员工。
SELECT
  e.EMPNO,
  e.ENAME
FROM emp e
WHERE e.JOB = (SELECT emp.JOB
               FROM emp
               WHERE emp.ENAME = 'scott');
# 11. 返回与30部门员工工资水平相同的员工姓名与工资。
SELECT
  e.ename,
  e.sal
FROM emp e
WHERE e.sal IN (SELECT sal
                FROM emp
                WHERE deptno = 30);
# 12. 返回工资高于30部门所有员工工资水平的员工信息。
SELECT
  e.ename,
  e.sal
FROM emp e
WHERE e.sal > (SELECT max(SAL)
               FROM emp
               WHERE DEPTNO = 30);
# 13. 返回部门号、部门名、部门所在位置及其每个部门的员工总数。
SELECT
  d.*,
  b.*
FROM dept d, (SELECT
                deptno,
                count(*) depnumber
              FROM emp
              GROUP BY deptno) b
WHERE d.deptno = b.deptno;
# 14. 返回员工的姓名、所在部门名及其工资。
SELECT
  e.ENAME,
  d.DNAME,
  e.SAL
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO;
# 15. 返回雇员表中不在同一部门但是从事相同工作的员工信息。
SELECT
  worker.ename,
  worker.empno,
  worker.sal,
  manager.ename,
  manager.empno,
  manager.sal
FROM emp worker LEFT JOIN emp manager ON worker.mgr = manager.empno;
# 16. 返回员工的详细信息，包括部门名。
SELECT
  e.EMPNO,
  e.ENAME,
  e.JOB,
  e.MGR,
  e.HIREDATE,
  e.SAL,
  e.COMM,
  e.DEPTNO,
  d.DNAME,
  d.LOC
FROM emp e LEFT JOIN dept d
    ON e.DEPTNO = d.DEPTNO
UNION
SELECT
  e.EMPNO,
  e.ENAME,
  e.JOB,
  e.MGR,
  e.HIREDATE,
  e.SAL,
  e.COMM,
  e.DEPTNO,
  d.DNAME,
  d.LOC
FROM emp e RIGHT JOIN dept d
    ON e.DEPTNO = d.DEPTNO;
# 17. 返回员工工作及其从事此工作的最低工资。
SELECT
  e.JOB,
  min(e.SAL) AS losalary
FROM emp e
GROUP BY e.JOB;
# 18. 返回不同部门经理的最低工资。
SELECT
  deptno,
  job,
  min(sal) AS lowsalary
FROM emp
WHERE JOB = 'manager'
GROUP BY deptno, job;
# 19. 计算出员工的年薪，并且以年薪排序。
SELECT
  e.EMPNO,
  e.ENAME,
  (e.SAL * 12 + ifnull(e.COMM, 0)) AS YEARSALARY
FROM emp e
ORDER BY YEARSALARY;
# 20. 返回工资处于第四级别的员工的姓名。
SELECT e.ENAME AS FOURTHLEVEL
FROM emp e
ORDER BY e.SAL
LIMIT 3, 1;