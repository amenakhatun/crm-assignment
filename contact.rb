class Contact

  # attr_accessor will give you both getters and setters,
  # attr_reader gives you just getters, and
  # attr_writer gives you just setters.
  attr_accessor :first_name, :last_name, :email, :note
  attr_reader :id
  #
  # def email
  #   @email
  # end
  #
  # def email=(new_email)
  #   @email= new_email
  # end


  #   Class variables
  # A class variable is a variable that's declared at the class level and shared across all objects of the same type. In our case, we'll setup a class variable to store the array of all the contacts we create. We'll also create a class variable called @@id to ensure that our contacts each have a unique identifier.
  @@contacts = []
  @@id = 1

  # Our initialize method should be responsible for setting the first name, last name, email, and note that get passed in from the create method.

  # This method should initialize the contact's attributes
  def initialize(first_name, last_name, email, note)
    @first_name = first_name # store in the instance variables
    @last_name = last_name
    @email = email
    @note = note

    # Additionally, it should set the id of the contact and increment the class @@id variable so that the next contact will get a different id.
    @id = @@id
    #@@id += 1 # this way the next contact will get a different id

    # @@contacts << self # self == The instance that was initialized
  end

  # Add a method to create new Contacts
  # Adding a contact to our CRM has two steps:
  # 1. first we need to make ("instantiate") a new contact object
  # 2. and then we need to save it into the list of contacts.
  # We want to keep our methods focused and simple so we'll separate the functionality of instantiating an object from the functionality of adding it to our list with a new class method.

  # This method should call the initializer,
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note)
    # 1. Initialize a new Contact with a unique ID
    new_contact = self.new(first_name, last_name, email, note)
    #new_contact = Contact.new(first_name, last_name, email, note)

    # 2. Add the new Contact to the contacts list
    @@contacts << new_contact

    # 3. increment the next unique ID
    @@id += 1

    # 4. Return the newly created contacts
    new_contact
  end

  # This method should return all of the existing contacts
  def self.all #self == Contact class
    @@contacts
  end

  # This method should accept an id as an argument
  # and return the contact who has that id
  def self.find(id)
    @@contacts.each do |contact|
      if contact.id == id
        return contact
      end
    end
  end

  #  Instance methods should involve logic that only make sense being applied to an instance of something, such as updating the email of a specific person. For example, be some_contact.update_email(email)

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  def update(attribute, value)

    case attribute
      when "first_name"
        self.first_name = value
      when "last_name"
        self.last_name = value
      when "email"
        self.email = value
      when "note"
        self.note = value
    end

    # send("#{attribute}=", value)
  end

  # A class method involves logic that should be applied on the whole scale of the model, such as cleaning up the email addresses of all the contacts. For example, Contact.clean_email_addresses.

  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty
  def self.find_by(attribute, value)
    results = []
    @@contacts.each do |contact|

      case attribute
        when "first_name"
          if contact.first_name.downcase.include?(value)
            results << contact
          end
        when "last_name"
          if contact.last_name.downcase.include?(value)
            results << contact
          end
        when "email"
          if contact.email.downcase.include?(value)
            results << contact
          end
        when "note"
          if contact.note.downcase.include?(value)
            results << contact
          end
      end
    end

    return results
  end

  # This method should delete all of the contacts
  def self.delete_all
    @@contacts = []
  end

  def full_name
    "#{first_name} #{last_name}" # Method calls
  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def delete
    @@contacts.delete(self)
  end

end


# Now whenever we want to make a new contact, we could do something like this:
# betty = Contact.create('Betty', 'Maker', 'bettymakes@gmail.com', 'Loves Pokemon')
# fred = Contact.create('Fred', 'Ngo', 'fred@gmail.com', 'Pizza')

# p betty.full_name # => 'bettymakes@gmail.com'
# p betty.note #=> 'Loves HTML & CSS'
# p betty.first_name
# p betty.full_name
# p fred.full_name

# p Contact.all
# p betty.id

# p Contact.find(1)
# betty.update("email", "betty@hotmail.com")
# p betty.email
#
# fred.update("note", "Yum")
# p fred.note
# betty.email = "betty@hotmail.com"
# p betty.email

#p Contact.find_by("last_name","Ngo")

# betty.delete
# p Contact.all

# Contact.delete_all
# p Contact.all
