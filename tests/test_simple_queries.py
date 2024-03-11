import unittest
from gradescope_utils.autograder_utils.decorators import weight, number
import mysql.connector
from decimal import Decimal
from queries import Queries
from constants import Constants




class TestSQLQueries(unittest.TestCase):
    weights = [0,5,5,10,10,10,10,10]
    expected_results = [
        [('1',), ('10',), ('11',), ('12',), ('13',), ('14',), ('15',), ('16',), ('17',), ('18',), ('19',), ('2',),
         ('20',), ('3',), ('4',), ('5',), ('6',), ('7',), ('8',), ('9',)],

        [('Professional Writing Skills',), ('Network Security Protocols',)],

        [(1, '91422 Sporer Rue Suite 780\nHershelfurt, SC 14307-6149'),
         (2, '808 Purdy Junction Apt. 386\nReillyborough, NJ 09796-7002'),
         (5, '32526 Lorenza Circle\nMertzshire, MD 91123'), (6, '292 Edison Roads Apt. 600\nAlliestad, VA 52205-1063')],

        [(1, 'Professional Writing Skills', 3), (2, 'Graphic Design Principles', 5),
         (3, 'Music Theory Introduction', 4), (5, 'World Religions Overview', 7), (6, 'Mechanical Systems Design', 5),
         (7, 'Public Speaking Mastery', 1), (8, 'Mobile App Development', 8), (9, 'Network Security Protocols', 4),
         (10, 'Investment Strategies', 6)],

        [(5, '172.16.0.2')],

        [(1, Decimal('9.0000')), (7, Decimal('9.0000')), (4, Decimal('6.5000')), (6, Decimal('6.0000')),
         (2, Decimal('5.8333')), (8, Decimal('5.0000')), (3, Decimal('4.2500'))],

        [(6, 'Mechanical Systems Design')],

        [('4',), ('14',), ('7',), ('3',), ('11',), ('9',), ('15',), ('5',), ('2',), ('6',)]
    ]
    def setUp(self):
        self.connection = mysql.connector.connect(user=Constants.USER, password=Constants.PASSWORD,
                                                  database=Constants.DATABASE)
        self.cursor = self.connection.cursor()
        self.queries = Queries()

    def tearDown(self):
        self.cursor.close()
        self.connection.close()

    def run_one_test(self, query, expect_result):
        self.cursor.execute(query)
        result = self.cursor.fetchall()

        try:
            self.assertCountEqual(result, expect_result, "Incorrect Query")
        except:
            raise Exception("Incorrect Query")

    @weight(weights[0])
    @number(0)
    def test_query0(self):
        self.run_one_test(self.queries.query0, self.expected_results[0])

    @weight(weights[1])
    @number(1)
    def test_query1(self):
        self.run_one_test(self.queries.query1, self.expected_results[1])

    @weight(weights[2])
    @number(2)
    def test_query2(self):
        self.run_one_test(self.queries.query2, self.expected_results[2])

    @weight(weights[3])
    @number(3)
    def test_query3(self):
        self.run_one_test(self.queries.query3, self.expected_results[3])

    @weight(weights[4])
    @number(4)
    def test_query4(self):
        self.run_one_test(self.queries.query4, self.expected_results[4])

    @weight(weights[5])
    @number(5)
    def test_query5(self):
        self.run_one_test(self.queries.query5, self.expected_results[5])

    @weight(weights[6])
    @number(6)
    def test_query6(self):
        self.run_one_test(self.queries.query6, self.expected_results[6])

    @weight(weights[7])
    @number(7)
    def test_query7(self):
        self.run_one_test(self.queries.query7, self.expected_results[7])