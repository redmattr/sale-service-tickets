from database import db

# Builds an event to be displayed on the home page
class eventBuilder():

    def __init__(self, id, name, desc, date, time, tickets_available, price):
        self.id = id
        self.name = name
        self.desc = desc
        self.date = date
        self.time = time
        self.tickets_available = tickets_available
        self.price = price

    def getID(self):
        return self.id

    def getName(self):
        return self.name
    
    def getDesc(self):
        return self.desc
    
    def getDate(self):
        return self.date
    
    def getTime(self):
        return self.time
    
    def getTicketsAvailable(self):
        return self.tickets_available
    
    def getPrice(self):
        return self.price
    
    def makeSerializable(self):
        return {"id": self.id, "name": self.name, "desc": self.desc, "date": self.date, "time": self.time, "tickets_available": self.tickets_available, "price": self.price}
        