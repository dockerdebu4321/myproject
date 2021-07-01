package com.debu.Springboot.tutorial.service;

import java.util.List;

import com.debu.Springboot.tutorial.entity.Department;
import com.debu.Springboot.tutorial.error.DepartmentNotFoundException;

public interface DepartmentService {
    public Department saveDepartment(Department department);

    public List<Department> fetchDepartmentList();

    public Department fetchDepartmentById(Long departmentId) throws DepartmentNotFoundException;

    public void deleteDepartmentById(Long departmentId);

    public Department updateDepartment(Long departmentId, Department department);

    Department fetchDepartmentByName(String departmentName);
}
