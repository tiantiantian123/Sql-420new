USE scott;
# 1. 查找部门30中员工的详细信息。
SELECT *
FROM emp;
# 2. 找出从事clerk工作的员工的编号、姓名、部门号。
SELECT EMPNO,ENAME,MGR
FROM emp
WHERE JOB='clerk';
# 3. 检索出奖金多于基本工资的员工信息。
SELECT *
FROM emp
WHERE COMM>emp.SAL;
# 4. 检索出奖金多于基本工资60%的员工信息。
SELECT *
FROM emp
WHERE COMM>emp.SAL*0.6;
# 5. 希望看到10部门的经理或者20部门的职员(clerk)的信息。
SELECT * FROM emp
WHERE (DEPTNO=10 OR DEPTNO=20)AND emp.JOB='clerk';
# 6. 找出10部门的经理、20部门的职员或者既不是经理也不是职员但是高于2000元的员工信息。
SELECT *
FROM emp
WHERE (DEPTNO=10 AND JOB='manager')OR (DEPTNO=20 AND JOB='clerk')OR (JOB!='manager'AND JOB!='clerk'AND SAL+emp.COMM>2000);
# 7. 找出获得奖金的员工的工作。
SELECT EMPNO,ENAME,JOB
FROM emp
WHERE COMM!=0;
# 8. 找出奖金少于100或者没有获得奖金的员工的信息。
SELECT *
FROM emp
WHERE (COMM<100)OR (COMM=0);
# 9. 查找员工雇佣日期中当月的最后一天雇佣的。
# select count(*) from emp
# where Convert(varchar(10),[%-%-30],120)=" + happen.toShortDateString（）
SELECT *
FROM emp
WHERE (day(HIREDATE)=30 AND (month(HIREDATE)=4 OR month(HIREDATE)=6 OR month(HIREDATE)=9 OR month(HIREDATE)=11))OR
(day(HIREDATE)=31 AND (month(HIREDATE)=1 OR month(HIREDATE)=3 OR month(HIREDATE)=5 OR month(HIREDATE)=7)or month(HIREDATE=8)OR month(HIREDATE=10)OR month(HIREDATE=12))
OR (day(HIREDATE)=28 AND month(HIREDATE)=2);
# 10. 检索出雇佣年限超过12年的员工信息。
SELECT *
FROM emp
WHERE 2016-year(HIREDATE)>12;
# 11. 找出姓名以A、B、S开始的员工信息。
SELECT *
FROM emp
WHERE (ENAME LIKE 'A%')OR (ENAME LIKE 'B%')OR(ENAME LIKE 'S%');
# 12. 找到名字长度为7个字符的员工信息。
SELECT *
FROM emp
WHERE length(ENAME)=6;
# 13. 名字中不包含R字符的员工信息。
SELECT *
FROM emp
WHERE ENAME NOT LIKE '%R%';
# 14. 找出员工名字的前3个字符。
SELECT left(ENAME,3)
FROM emp;
# 15. 将名字中A改为a。
SET @ename='';
UPDATE emp
SET @ename=substr(ENAME,0,1)
WHERE ENAME='A'+@name1;

# 16. 将员工的雇佣日期拖后10年。
# 17. 返回员工的详细信息并按姓名排序。
# 18. 返回员工的信息并按员工的工作年限降序排列。
# 19. 返回员工的信息并按工作降序工资升序排列。
# 20. 返回员工的姓名、雇佣年份和月份并且按月份和雇佣日期排序。
# 21. 计算员工的日薪(按30天)。
# 22. 找出2月份雇佣的员工。
# 23. 至今为止，员工被雇佣的天数。
# 24. 找出姓名中包含A的员工信息。
# 25. 计算出员工被雇佣了多少年、多少月、多少日。