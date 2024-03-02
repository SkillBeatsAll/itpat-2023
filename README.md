![EnviroPOS Logo](/Logo.svg)
IT Practical Assessment Task - 2023 _Grade 12_
==========================================


This PAT strongly focuses on Object-Oriented Programming (OOP) and is based on a Point-of-Sale system. The PAT, coded in Delphi (Pascal), is complete with comments, high-quality code, help documentation, and more.
> This PAT is fricking awesome!
> ~ Subject Head

    Final Grade: 150/150 (100%)

![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fhits.dwyl.com%2FSkillBeatsAll%2Fitpat-2023.json&style=flat-square&logo=github&logoColor=springgreen&label=visitors&color=seagreen) ![Static Badge](https://img.shields.io/badge/license-MIT-seagreen?style=flat-square&labelColor=grey)

## Table of contents
- IT Practical Assessment Task - 2023 Grade 12
	- [Table of contents](#table-of-contents)
	- [Introduction - EnviroPOS](#introduction---enviropos)
	- [Topic](#topic)
	- [Usage](#usage)
	- [Getting help](#getting-help)
	- [License](#license)


## Introduction - EnviroPOS
This repository contains all the required files to compile the PAT. The PAT is based on the provided [topic](#topic) and is complete with comments, custom functions and procedures, a database, class files, text files for importing/exporting, a help 'website' (.html files), appropriate hints, and more.

This project consists of 11 forms:

 1. Authentication Form: Complete with a beautiful, simplistic GUI where users will log in to the program.
 2. Registration Form: Where users will register as a *cashier* or a *supplier*. (Managers are registered on the first run of the program.)
 3. Authentication-help Form: **2FA**[^1] for suppliers/managers. Used to provide help setting up 2FA (QR code [^2]), which is done with a beautiful GUI and fluent instructions.
 4. EnviroPOS Main Form: This form serves as a gateway to the other functions of the POS software, and shows basic stats at a glance to the user.
 5. New Order Form: Form where cashiers start an order for a customer. Features order exporting through **emailing** directly to the customer and utilises OOP and a class to manage the order.
 6. Dialog Form: This custom dialog form allows the user to choose between adding or managing a customer.
 7. Customer Management Form: Customer details and all their orders and the order-specific details can be seen here.
 8. Add Customer Form: A cashier can add a customer to the database here.
 9. Inventory Management Form: Items can be added to the database by suppliers, and their details can be modified here too.
 10. Admin Centre: Grants the manager (administrator) direct access to the database.
 11. Help Browser: Loads the help documentation html file. 

## Topic

<ins>***Save our Planet***</ins> [^3]

Our environment is constantly changing, and there is a need to become increasingly aware of the
environmental issues that are causing these changes. Environmental issues are defined as
harmful effects to the Earth and its natural systems due to the actions of humans.

There is a massive increase in natural disasters related to global warming which affect weather
patterns, and people need to be a lot more cautious in the way they lead their lives in conjunction
with the types of environmental issues our planet is facing. 

The responsibility lies with mankind to take on the initiative to do more to protect and save our
planet.

Projects in the scenario above could include the following topics related to addressing
environmental issues towards saving our planet:
1. A system to manage fund-raising projects on saving/protecting endangered animals, such as
rhinos, whales, etc./information system providing information on endangered species
2. A system to manage voluntary projects/activities related to the environments, such as beach
and park clean-ups
3. A system to manage the reduction, reuse and recycling of materials such as glass, plastic,
paper or other products
4. An online store for the sale of environmentally friendly/energy-efficient/eco-friendly products,
e.g. LED lights and solar panels
5. A system to manage workshops/educational programmes to mobilise/encourage actions to
address environmental issues. Activities/Programmes may include planting trees, saving
water and electricity, the reduction of waste materials, ways of producing eco-friendly
food/other products.
6. A system to provide information on types of electrical vehicles, bicycles and other ways of
promoting the use of alternative energy sources for transport
7. A system to keep track of/provide information on aspects related to climate change, such as
changes in weather patterns/occurrences of natural disasters, etc.
8. A system to manage data on blogs/forums/social media/magazines related to environmental
issues and/or weather/climate-related issues
9. A system to provide information on the levels/affects/activities leading to
air/water/plastic/other forms of pollution in the world/countries/regions
10. A system for solid-waste management which entails the storage, collection, transfer and
transport, processing and disposal of solid waste in such a manner that it does not have a
harmful effect on the environment

**NOTE:** The system does not have to be executed online.

Choose an application related to saving our planet and do research on the information system
requirements.

You are not limited to the list of ideas above, but you need to keep within the overall theme – Save
our planet.

Note that you need to choose data and functionalities (services) in such a way as to develop a
well-rounded application related to the topic.

**NOTE**: Your final program must comprise ***one*** single project with logically related parts.

## Usage
This project can be compiled and run through the Delphi IDE (RAD Studio). The executable file will be saved under `/Win32/Debug` in the project folder, which can then be distributed.  
Note that this project was created using *Rad Studio 11*, and might not compile in older versions of Rad Studio.

**VERY IMPORTANT:** For this PAT to compile, _**YOU MUST INSTALL `SVGIconImageList` AS A GetIt PACKAGE!**_

## Getting help
You can contact me via [email](mailto:joelcedras@gmail.com), via [Twitter](https://twitter.com/JoelBeatsAll), or via [Discord](https://discordhub.com/profile/234576713005137920).

License  
-------  
  
This project is distributed under the terms of the [MIT license](/LICENSE). The license applies to this file and other files in the [GitHub repository](http://github.com/SkillBeatsAll/itpat-2023) hosting this file.

```
MIT License

Copyright (c) 2023 Joel Cedras / SkillBeatsAll

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```


[^1]: Utilizes [DelphiOTP](https://github.com/wendelb/DelphiOTP) by wendelb, licensed under MIT.
[^2]: Using ZXing QRCode port to Delphi, by Debenu Pty Ltd
[^3]: Provided by the Department of Basic Education [here](https://www.education.gov.za/Portals/0/Documents/PATS%202023%20Grade%2012/PATs%20Grade%2012%202023%20PDF/Information%20Technology/Information%20Technology%20PAT%20GR%2012%202023%20Eng.pdf?ver=2023-01-16-115728-000)
