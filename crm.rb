# Note that the CRM class needs to makes use of the Contact class, for example in the add_new_contact method. Many of the other methods in the CRM class will also make use of the Contact class.

# Classes work together to make the entire program functional. We let classes use other classes by importing a file. The way this is done is using a method called require_relative, and basically what it does is get that file and stick it right in that line where the require_relative method was called.

require './contact'

class CRM

  # When we want to create a new instance of a class, we call a method named new (as in CRM.new). In some cases we want it so that arguments have to be passed in, for example the new instance you make has to be given a name. In other words, you want to see something like this: CRM.new("My CRM App").

  # For this to be done we need to manipulate a method named initialize in the class.
  # initialize and new are synonymous, so when you call new, you're calling initialize.
  def initialize(name)
    @name = name
  end

  # Prompt the user to select from a main menu. The code for that might look something like this:
  # We have two methods: print_main_menu prints out the menu and main_menu calls print_main_menu and then stores the user input (a number) into a variable called user_selected. That variable then gets passed as an argument into a method we haven't defined yet called call_option.
  def main_menu
    while true # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  # user_selected is going to be a number. What we want to do in this method is call other methods based on the number. We've started off this method for you:
  def call_option(user_selected)
    case user_selected
      when 1 then add_new_contact
      when 2 then modify_existing_contact
      when 3 then delete_a_contact
      when 4 then display_all_contacts
      when 5 then search_by_attribute
      when 6 then exit
    end

  end

  # The add_new_contact method might looks something like this:
  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    c = Contact.create(first_name, last_name, email, note)
    puts "Name: #{c.full_name} Email: #{c.email} Note: #{c.note} was created"
  end

  def modify_existing_contact
    display_all_contacts

    print 'Enter the ID of the contact to modify: '
    id = gets.chomp.to_i
    c = Contact.find(id)
    display_a_contact(c)

    p "Enter an attribute to modify:  "
    print "Enter: First name, Last Name, Email and Note "
    attribute = gets.chomp.downcase.split(" ").join("_").to_s

    print "Enter a new value: "
    value = gets.chomp.to_s
    c.update(attribute, value)

    display_a_contact(c)
  end

  def delete_a_contact

    print 'Enter the ID of the contact to delete: '
    id = gets.chomp.to_i
    c = Contact.find(id)
    display_a_contact(c)
    print "Are you sure you would like to delete?(y/n) "
    answer = gets.chomp.downcase.to_s
    if answer == "y"
      c.delete
    else
      main_menu
    end

  end

  def display_all_contacts
    all_c = Contact.all
    all_c.each do |c|
      puts "ID: #{c.id} Name: #{c.full_name} Email: #{c.email} Note: #{c.note}"
    end
  end

  def display_a_contact(c)
    puts "ID: #{c.id} Name: #{c.full_name} Email: #{c.email} Note: #{c.note}"
  end

  def search_by_attribute
    print "Enter an attribute you would like to search: First name, Last Name, Email and Note "
    attribute = gets.chomp.downcase.split(" ").join("_").to_s

    print "Enter the search value: "
    value = gets.chomp.downcase.to_s
    contacts = Contact.find_by(attribute, value)

    p "Here is the search result"
    contacts.each do |contact|
      display_a_contact(contact)
    end
  end

end

# Now how do we call methods that are inside of classes? Like this:
# We're creating a new instance of the class CRM, and we're saving that new instance into a variable called a_crm_app. This is just like having a blueprint of a house, and every time you build a house off the blueprint you create a new instance of a house.

# Then we can call the methods that we defined inside the class on the instance. main_menu and print_main_menu are methods inside of the class CRM, and we can call them on a_crm_app, which is an instance of the class. For example, a_crm_app.main_menu tells a_crm_app to perform the main_menu action.
crm_app = CRM.new("CRM APP")
crm_app.main_menu

# If we wanted to call print_main_menu instead, that would look like:
#crm_app.print_main_menu
