# load 'contact.rb'
require_relative 'contact'
require_relative 'rolodex'

class CRM

	def self.run
		my_crm = CRM.new
		my_crm.main_menu
	end

	def initialize
		@rolodex = Rolodex.new
	end

	def print_main_menu
		puts "[1] Add new contact"
		puts "[2] Modify an existing contact"
		puts "[3] Delete a contact"
		puts "[4] Display all the contacts"
		puts "[5] Display an attribute"
		puts "[6] Exit"
		puts "Enter a selection"
	end

	def call_selection(selection)
		add_new_contact if selection == 1
		modify_contact if selection == 2
		delete_contact if selection == 3
		display_contact if selection == 4
		display_by_attribute if selection == 5
		exit if selection == 6
	end

	def main_menu
		while true
			print_main_menu
			selection = gets.chomp.to_i
			call_selection(selection)
		end
	end

	def add_new_contact
		print "First name: "
		first_name = gets.chomp
		print "Last name: "
		last_name = gets.chomp
		print "Email: "
		email = gets.chomp
		print "Note: "
		note = gets.chomp
  	contact = Contact.new(first_name, last_name, email, note)
  	@rolodex.add_contact(contact)
	end

	def modify_contact
		puts "Enter contact id: "
		contact_id = gets.chomp.to_i
		contact = @rolodex.find(contact_id)
		puts "Enter yes or no to confirm selection"
		confirmation = gets.chomp
		if confirmation == "yes"
			
			puts "Which would you like to change?"
			puts "Enter 1 for First name"
			puts "Enter 2 for Last name"
			puts "Enter 3 for Email"
			puts "Enter 4 for Note"
			answer = gets.chomp.to_i
				
		  contact.first_name = gets.chomp if answer == 1
		  contact.last_name = gets.chomp if answer == 2
		  contact.email = gets.chomp if answer == 3
		  contact.note	= gets.chomp if answer == 4
				
			puts contact.to_s


		  elsif answer == "no"
		  	main_menu
		  end
	end

	def delete_contact
		puts "Enter id of user you want to delete: "
		contact_id = gets.chomp.to_i
		
		if contact = @rolodex.delete(contact_id)
			puts "Contact deleted!"
		else
			puts "Couldn't find contact #{contact_id}"
		end

		main_menu

	end

	def display_contact
		print "Enter id of user you would like to view: "
		contact_id = gets.chomp.to_i
		contact = @rolodex.find(contact_id)
		puts contact.to_s
		main_menu
	end

	def display_by_attribute
		puts "Enter an attribute(firstname, lastname, email, notes)"
		choice = gets.chomp.to_i
		
		@rolodex.each_contact do |contact|
			case choice
			when 1
				puts contact.first_name
			when 2
				puts contact.last_name
			when 3
				puts contact.email
			when 4
				puts contact.note
			end
		end
	end

	def exit
		exit
	end


end

CRM.run