-- ex. 2
    -- branchNo -> branch Adress --> Branches(brnachNo*, branchAddress)
    -- staffNo -> name, position --> Staff(staffNo*, name, position)
    -- make sure hrs/week does depend on both by looking at dependency
    -- brancNo, staffNo -> hoursperweek --> BranchStaff(branchNo*, StaffNo*, hoursPerWeek)
    -- use the notation he wrote w/

-- ex.3
    -- A) You would have to put a line and copy the data to seperate into diff. rows and 
    --    columns as well for procedure maybe (proc id, proc description)
    -- B) confirm if there multiple owners if true then it becomes a multi value attribute that
    --    will have to be broken down 


-- ex. 4
    -- single key no 3rd Form violation
    -- INV
    -- Invoices (num, date, custName, petName, )
    -- how would we break down custName -> cust id, cust name?
    -- breake petName -> 
    -- redoing the thing?
    -- Invoices(name*, petName*, description*, date, custName, amt)
    -- Customers(custName*, custAddress)
    -- key is compound but

    -- sol?
    key is: {num, petName, description}
    num -> date, custName, (2NF violoation)
    
    2NF:
    InvoiceDetails(num*, petName*, description*, amt)
    Invoices(num*, date, custName, custAddress)

    custName -> custAddress (3NF violation)

    After 3NF:
    InvoiceDetails(num*, petName*, description*, amt)
    Invoices(num*, date, custName, custAddress)
    Custmers(custName*, custAddress)

    Further improvement
    Break description into code and description

    key is: {num, petName, description}
    code -> description (2NF violation)

    After2NF:
    InvoiceDetails(num*, petName*, code*, amt)
    Procedures(code*, description)
    Invoices(num*, date, custName)
    Customers(custName*, custAddress)

    Improvement 2:
    Add custEmail

    InvoiceDetails(num*, petName*, code*, amt)
    Procedures(code*, description)
    Invoices(num*, date, custName)

    custEmail -> custName, custAddress (3NF violation)

    After 3NF:
    InvoiceDetails(num*, petName*, description*, amt)
    Invoices(num*, date, custName, custAddress)
    Custmers(custName*, custAddress)
    Procesdures(code*, description)

    -- Exercise: How would your model change if you have invoice number unique

-- This is why is important to make a good model beforehand, avoids complexity and nf 
-- violations 
