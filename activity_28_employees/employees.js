// create db
use employees;

// create collection
db.employees.insertMany([
    {
        name: 'John', 
        department: 'sales', 
        projects: ['bluffee', 'jomoorjs', 'auton' ]
    },

    {
        name: 'Mary', 
        department: 'sales', 
        projects: ['codete', 'auton' ]
    },

    {
        name: 'Peter', 
        department: 'hr', 
        projects: ['auton', 'zoomblr', 'instory', 'bluffee' ]
    },

    {
        name: 'Janet', 
        department: 'marketing', 
    },

    {
        name: 'Sunny', 
        department: 'marketing', 
    },

    {
        name: 'Winter', 
        department: 'marketing', 
        projects: [ 'bluffee', 'auton' ]
    },

    {
        name: 'Fall', 
        department: 'marketing', 
        projects: [ 'bluffee', 'scrosnes' ]
    },

    {
        name: 'Summer', 
        department: 'marketing', 
    },

    {
        name: 'Sam', 
        department: 'marketing', 
        projects: ['scrosnes' ]
    },

    {
        name: 'Maria', 
        department: 'finances', 
        projects: ['conix', 'filemenup', 'scrosnes', 'specima', 'bluffee' ]
    }
])

// number of emplyees per department
// hint: use the groupandsum pipeline opertors
db.employees.aggregate(
    [
        {
            $group:
                {
                    _id: "$department", 
                    employees: {        // nam for field of number of employees
                        $sum: 1
                    }
                }
        },
        {
            $sort:
                {
                    _id: 1
                }
        }
    ]
)

// same but in alphabetical order
// already did above

//same but in descending oder by number of employees
db.employees.aggregate(
    [
        {
            $group:
                {
                    _id: "$department", 
                    employees: {        // nam for field of number of employees
                        $sum: 1
                    }
                }
        },
        {
            $sort:
                {
                    employees: -1
                }
        }
    ]
)

// alphabetic list of all project names
// hing: first use
