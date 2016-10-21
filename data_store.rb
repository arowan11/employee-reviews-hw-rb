require 'csv'
require_relative './employee'
require_relative './department'

class DataStore

  def initialize
    @employees = []
    @departments = []

  end

  attr_accessor :employees, :departments

  def all(key=nil)
    return { employees: employees, departments: departments } unless key
    send(key) if key
  end

  def add(object)
    if object.is_a? Employee
      employees << object
    else
      departments << object
    end
  end

  def get(type, key, value)
      send(type).select { |object| object.send(key) == value }
  end

  def deep_save
    employee_data = employees.map{ |employee| employee.to_hash }.to_csv
    department_data = departments.map { |department| department.to_hash }.to_csv
    File.open('./data/employees.csv', 'w') {|f| f.write(employee_data) }
    File.open('./data/departments.csv', 'w') {|f| f.write(department_data) }

  end

end
