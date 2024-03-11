import mysql.connector
from constants import Constants

class Queries(object):

    """example queries, to show how this framework work"""
    query0 = """
        SELECT 
            UCINetID 
        FROM 
            Users;
    """

    """find the titles of all courses offered in the 'Fall' quarter."""
    query1 = """
        SELECT Title
        FROM Courses
        WHERE Quarter = 'Fall';
    """

    """find all machine IDs and their locations where the operational status is busy"""
    query2 = """
    SELECT MachineID, Location
    FROM Machines
    WHERE OperationalStatus = 'busy'
    """

    """count the number of students enrolled in each course and return them in (CourseID, Title, number of enrollments), based on the projects they are doing."""
    query3 = """
    SELECT 
        c.CourseID, 
        c.Title, 
        COUNT(DISTINCT sump.StudentUCINetID) AS NumberOfEnrollments
    FROM 
        Courses c
    INNER JOIN 
        Projects p ON c.CourseID = p.CourseID
    INNER JOIN 
        StudentUseMachinesInProject sump ON p.ProjectID = sump.ProjectID
    GROUP BY 
        c.CourseID, 
        c.Title
    """

    """given a SoftwareID 8, list all machines (MachineID and IPAddress) that have this software installed."""
    query4 = """
    SELECT DISTINCT m.MachineID, m.IPAddress
    FROM Machines m
    INNER JOIN
        SoftwareOfProjectInstallOnMachine spim ON m.MachineID = spim.MachineID
    WHERE 
        m.SoftwareID = 8
    """

    """calculate the average duration of maintenance for each machine, return (MachineID, Average duration), sorted from highest to lowest"""
    query5 = """
    """

    """find the course(s) (CourseID and Title) that has(have) the highest number of associated projects."""
    query6 = """
    """

    """Identify students(StudentIDs) who have used machines with "busy" status and "idle" status at least once"""
    query7 = """
    """