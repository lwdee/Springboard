/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform.

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.
 */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */
SELECT  `name` 
  FROM  `Facilities` 
 WHERE  `membercost` > 0


/* Q2: How many facilities do not charge a fee to members? */
SELECT COUNT(  `name` ) AS count_of_no_member_fee_facilities
  FROM  `Facilities` 
 WHERE  `membercost` =0


/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT  `facid` ,  `name` ,  `membercost` ,  `monthlymaintenance` 
FROM  `Facilities` 
WHERE membercost > 0
AND (
membercost / monthlymaintenance
) < .2


/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */
SELECT * 
FROM  `Facilities` 
WHERE facid
IN ( 1, 5 ) 


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */
SELECT  `name` ,  `monthlymaintenance` , 
CASE WHEN monthlymaintenance >100
     THEN  'expensive'
     ELSE  'cheap'
     END AS maintenance_class
FROM  `Facilities` 


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT mem.firstname, mem.surname, mem.joindate
FROM  `Members` mem
JOIN (SELECT MAX( joindate ) AS max_date
      FROM  `Members`)mdate 
ON mem.joindate = mdate.max_date

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT (f.name) AS facility_name, 
CONCAT( m.firstname,  ' ', m.surname ) AS member_name
FROM  `Bookings` b
JOIN  `Facilities` f ON b.facid = f.facid
JOIN  `Members` m ON b.memid = m.memid
WHERE b.facid IN ( 0, 1 ) 
AND m.firstname NOT LIKE  'GUEST%'
GROUP BY 2 
ORDER BY member_name

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT f.name AS facility_name, CONCAT( m.firstname,  ' ', m.surname ) AS member_name, 
CASE WHEN m.memid =0
THEN f.guestcost * b.slots
ELSE f.membercost * b.slots
END AS cost

FROM  `Bookings` b
JOIN  `Facilities` f ON b.facid = f.facid
JOIN  `Members` m ON b.memid = m.memid

WHERE b.starttime LIKE  '2012-09-14%'
HAVING cost >30
ORDER BY cost DESC

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT sub.facility_name, 
       sub.member_name,
       sub.cost 

FROM (SELECT  f.name AS facility_name, 
      CONCAT( m.firstname,  ' ', m.surname ) AS member_name,  
      CASE WHEN m.memid =0 THEN f.guestcost * b.slots 
      ELSE f.membercost * b.slots END AS cost

    FROM 
      (SELECT *
       FROM  `Bookings`
       WHERE starttime LIKE  '2012-09-14%') b -- Smaller section of the table.

    JOIN  `Facilities` f ON b.facid = f.facid
    JOIN  `Members` m ON b.memid = m.memid) sub
    

WHERE cost >30 -- This allows us to use WHERE instead of HAVING
ORDER BY cost DESC

/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

-- Sum slots per mem/guest, calc revenue, group by facility, filter <1000

SELECT sub.name AS facility_name, 
(sub.guest_slots * sub.guestcost) + ( sub.member_slots * sub.membercost ) AS revenue

FROM (
      SELECT f.name, 
      SUM(CASE WHEN b.memid =0 THEN b.slots ELSE NULL END) AS guest_slots, 
      SUM(CASE WHEN b.memid !=0 THEN b.slots ELSE NULL END) AS member_slots, 
      f.guestcost, f.membercost
      FROM  `Bookings` b
      JOIN  `Facilities` f 
      ON b.facid = f.facid
      GROUP BY 1
      )sub
HAVING revenue <1000
ORDER BY revenue

