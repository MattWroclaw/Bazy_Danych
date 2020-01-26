DROP Procedure if Exists `Get_Emplyee_Infos` ;
DELIMITER $$

Create Procedure Get_Emplyee_Infos(p_Emp_Id Integer,
								out v_First_Name Varchar(50),
								Out v_Last_Name Varchar(50),
								Out v_Dept_Id Integer)
BEGIN 
	SELECT Concat('Parameter p_Emp_Id = ' , p_Emp_Id) as log_info1;
    
    SELECT Emp.First_Name,
			Emp.Last_Name,
			Emp.Dept_Id
		INTO v_First_Name,
			v_Last_Name,
            v_Dept_Id
		FROM employee employee
        WHERE Emp.Emp_id=p_Emp_Id;
        
        Select 'Found Rwcord!' as log_info2;
        Select concat('v_First_name= ' , v_First_Name) as log_info3;
        Select concat('v_Last_name= ' , v_Last_Name) as log_info4;
        Select concat('v_Dept_Id= ', v_Dept_Id) as log_info5;
        
        End;
        
        
        