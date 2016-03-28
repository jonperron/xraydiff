# -*- coding:utf-8 -*

import os
os.path.dirname(os.path.abspath(__file__)) #current file location
import math

#Select between single swap or hysteresis
choice = 0
while choice == 0:
	print("1. Single swap \n")
	print("2. Hysteresis \n")
	choice = input("Your choice ? ")
	
	try:
		choice = int(choice)
	except ValueError:
		print("Your choice must be a number...")
		choice = 0
		continue
		
	if choice !=1 and choice !=2 : #or is not working here
		print("This option is not valid.")
		choice = 0
		continue
		
		
while choice == 1:

	#Input values and check if numbers !
	start_value = -1
	end_value = -1
	number_steps = -1
	angle_theta = -1 #angle between x axis and magnetic field
	set_up = False

	while set_up == False:

		while start_value == -1:
			start_value = input("Start value of the magnetic field ? in Oe ")
			try:
				start_value=float(start_value)
			except ValueError:
				print("Start value must be a number...")
				start_value = -1
				continue

		while end_value == -1:
			end_value = input("End value of the magnetic field  ? in Oe ")
			try:
				end_value=float(end_value)
			except ValueError:
				print("End value must be a number...")
				end_value = -1
				continue
			
		while number_steps == -1:
			number_steps = input("Number of steps ? ")
			try:
				number_steps = int(number_steps)
			except ValueError:
				print("Number of steps must be a number...")
				number_steps = -1
				continue
				
		while angle_theta == -1:
			angle_theta = input("Angle between x axis and magnetic field ? in degrees ")
			try:
				angle_theta = float(angle_theta)
			except ValueError:
				print("Angle must be a number...")
				angle_theta = -1
				continue
				
		set_up = True
			
	while set_up == True:

		print("The magnetic field will be varied between",start_value,"Oe and",end_value,"Oe.")
		print("The number of steps is",number_steps,".")
		increase = (end_value - start_value)/number_steps
		print("The field will be increased by",increase,"between two steps.")
		print("An angle of",angle_theta,"degrees is used.")
	
#open file in write mode / OVERWRITE if file already exists	
		batch_file = open("batch.bat",'w') 
#path to MinGW
		batch_file.write("SET PATH=%PATH%;C:\MinGW\\bin\n")
 
		increment =  1
		new_start_value = start_value
		angle_theta = angle_theta*math.pi/180 #conversion from degrees to rad
		previous_dat_file = " "
		
		while increment <= number_steps+1:
			increment += 1
			for_dat_file = int(new_start_value) #for the filename of the resulting .dat file
			h_x = new_start_value*math.cos(angle_theta) #component along x
			h_x=round(h_x,2)
			h_y = new_start_value*math.sin(angle_theta) #component along y
			h_y=round(h_y,2)
			batch_file.write("pippo.exe %s %s h%s.dat %s \n" %(h_x,h_y,for_dat_file,previous_dat_file))
			previous_dat_file = "h%s.dat" %(for_dat_file)
			batch_file.write("main.exe h%s.dat test_h%s.dat \n" %(for_dat_file,for_dat_file))
			batch_file.write("SCSCalc2_xr.exe header_xr.dat test_h%s.dat itest_h%s \n" %(for_dat_file,for_dat_file))
			new_start_value += increase
#			new_end_value += increase
 
		batch_file.write('pause')
		batch_file.close()
	
 #set value back otherwise, infinite loop...
		set_up = False
		choice = 0


while choice == 2:

	start_value = -1
	end_value = -1
	number_steps = -1
	angle_theta = -1
	set_up = False

	while set_up == False:

		while start_value == -1:
			start_value = input("Start value of the magnetic field (in x) ? in Oe ")
			try:
				start_value=float(start_value)
			except ValueError:
				print("Start value must be a number...")
				start_value = -1
				continue

		while end_value == -1:
			end_value = input("End value of the magnetic field (in x) ? in Oe ")
			try:
				end_value=float(end_value)
			except ValueError:
				print("End value must be a number...")
				end_value = -1
				continue
			
		while number_steps == -1:
			number_steps = input("Number of steps ? ")
			try:
				number_steps = int(number_steps)
			except ValueError:
				print("Number of steps must be a number...")
				number_steps = -1
				continue

		while angle_theta == -1:
			angle_theta = input("Angle between x axis and magnetic field ? in degrees ")
			try:
				angle_theta = float(angle_theta)
			except ValueError:
				print("Angle must be a number...")
				angle_theta = -1
				continue
		
		set_up = True
		
	while set_up == True:
	
		print("The magnetic field will be varied between",start_value,"Oe and",end_value,"Oe.")
		print("The number of steps is",number_steps,".")
		increase = (end_value - start_value)/number_steps
		print("The field will be increased by",increase,"between two steps.")
		print("An angle of",angle_theta,"degrees is used.")
	
#open file in write mode / OVERWRITE if file already exists	
		batch_file = open("batch.bat",'w') 
#path to MinGW
		batch_file.write("SET PATH=%PATH%;C:\MinGW\\bin\n")
 
		increment =  1
		new_start_value = start_value
		number_steps = 2*number_steps
		angle_theta = angle_theta*math.pi/180 #conversion in rad
		previous_dat_file = " "
		
		while increment <= number_steps/2:
			increment += 1
			for_dat_file = int(new_start_value)
			h_x = new_start_value*math.cos(angle_theta) #component along x
			h_x = round(h_x,2)
			h_y = new_start_value*math.sin(angle_theta) #component along y
			h_y = round(h_y,2)
			batch_file.write("pippo.exe %s %s h%s_a.dat %s \n" %(h_x,h_y,for_dat_file,previous_dat_file))
			previous_dat_file = "h%s_a.dat" %(for_dat_file)
			batch_file.write("main.exe h%s_a.dat test_h%s_a.dat \n" %(for_dat_file,for_dat_file))
			batch_file.write("SCSCalc2_xr.exe header_xr.dat test_h%s_a.dat itest_h%s_a \n" %(for_dat_file,for_dat_file))
			new_start_value += increase
			continue

		
		while increment <= number_steps+1: #n+1 to go back to start_value
			increment += 1
			for_dat_file = int(new_start_value)
			h_x = new_start_value*math.cos(angle_theta) #component along x
			h_x = round(h_x,2)
			h_y = new_start_value*math.sin(angle_theta) #component along y
			h_y = round(h_y,2)
			batch_file.write("pippo.exe %s %s h%s_b.dat %s \n" %(h_x,h_y,for_dat_file,previous_dat_file))
			previous_dat_file = "h%s_b.dat" %(for_dat_file)
			batch_file.write("main.exe h%s_b.dat test_h%s_b.dat \n" %(for_dat_file,for_dat_file))
			batch_file.write("SCSCalc2_xr.exe header_xr.dat test_h%s_b.dat itest_h%s_b \n" %(for_dat_file,for_dat_file))
			new_start_value -= increase
			continue
			
		batch_file.write('pause')
		batch_file.close()
	
 #set value back otherwise, infinite loop...
		set_up = False
		choice = 0
	
os.system("pause")