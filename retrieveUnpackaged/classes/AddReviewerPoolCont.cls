public class AddReviewerPoolCont {
    
    public string qryStr{get;set;}
    public List<contactWrapper> wrappedContacts {get; set;}
    public Contact con{get;set;}
    public decimal rating{get;set;}
    public decimal yrsofexp{get;set;}
    public set<Id> contactIdsfromPool = new set<Id>();
    public list<Contact> lContacts{get;set;} 
    public string debugsoql{get;set;}
    public NOFA_Group__c panel;
    public string lastName{get;set;}
    public String personId{get;set;}
    public String selectedstates{get;set;}
    public String selectedexpertise{get;set;}
    public String selectedareaofExpertise{get;set;}
    
    public AddReviewerPoolCont() {
        
        /*list<Reviewer_Pool__c> poolMembers = new list<Reviewer_Pool__c>();
        //String panelId = ApexPages.currentPage.getParameters.get('id');
        
        if(ApexPages.currentPage().getParameters().get('id')!=null)
            panel = [Select Id,Name,Review_Type__c,Status__c from NOFA_Group__c where Id = :ApexPages.currentPage().getParameters().get('id')];
            
        if(panel!=null)         
            poolMembers = new list<Reviewer_Pool__c>([Select Id,Expert_Reviewer_Name__c from Reviewer_Pool__c where Status__c = 'Available' ]);
        
        if(poolMembers.size()>0){   
            for(Reviewer_Pool__c r: poolMembers){
                contactIdsfromPool.add(r.Expert_Reviewer_Name__c);
            }
        }*/
        con = new Contact();
         //con =[Select Id,Name,Email,Area_of_Expertise__c,Expertise__c ,Years_of_Experience__c,Highest__c,Performance_Rating__c,State_of_Residence__c,Status__c from Contact where Id in :contactIdsfromPool and status__c='Accepted' ];
        
    }
    
    
    
    public List<contactWrapper> getContacts() {
        lContacts = new list<Contact>([Select Id,Name,Email,Area_of_Expertise__c,Expertise__c,Years_of_Experience__c ,Highest__c,Performance_Rating__c,State_of_Residence__c,Status__c from Contact where  status__c='Accepted' and RecordType.Name ='Expert Reviewer']);
        
        if(wrappedContacts == null) {
            wrappedContacts = new List<contactWrapper>();  
            for(Contact c: lContacts){
                wrappedContacts.add(new contactWrapper(c));
            }                     
        }
        return wrappedContacts;

    }

    public void runSearch(){
        system.debug('in search');
        string soql;
        /*string area = Apexpages.currentPage().getParameters().get('area');
        //string education = Apexpages.currentPage().getParameters().get('education');
        string status = Apexpages.currentPage().getParameters().get('status');
        string residence = Apexpages.currentPage().getParameters().get('residence');
        String  rating1= Apexpages.currentPage().getParameters().get('rating');
        String  yrsofexp1= Apexpages.currentPage().getParameters().get('yrsofexp');
        String  expertise= Apexpages.currentPage().getParameters().get('expertise');
        String  fName = Apexpages.currentPage().getParameters().get('fName');
        String  lName = Apexpages.currentPage().getParameters().get('lName');
        String  email = Apexpages.currentPage().getParameters().get('email');
        String  personId = Apexpages.currentPage().getParameters().get('personId');
        String highestEdu = Apexpages.currentPage().getParameters().get('highestEdu');
        */
        
        system.debug('states = '+selectedStates);
        
        string fname = '';
        if(con.FirstName != null)
       		fname = con.FirstName;     	     		
              
        string lname = lastName;
        
        string email = '';
        if(con.Email !=null)
        	email = con.Email;
        	
        string pId = personId;        
        
        string status = '';
        if(con.Status__c != null)
        	status = con.Status__c;  
        	      	
        string rating1 = '';
        if(con.Performance_Rating__c != null)
        	rating1 = string.valueOf(con.Performance_Rating__c);
        	
                         
        string yrsofexp1 = '';
        if(con.Years_of_Experience__c != null)
        	yrsofexp1 = string.valueOf(con.Years_of_Experience__c);    
        	    
        string highestEdu = '';
        if(con.Highest__c != null)
        	highestEdu = con.Highest__c;
        	
        string residence = '';
        if(selectedStates != null)
        	residence = selectedstates;
        	
        string area = '';
        if(selectedareaofExpertise != null)
        	area = selectedareaofExpertise;
        	
        string expertise = '';
        if(selectedexpertise != null)
        	expertise = selectedexpertise;
        
       
        
        if(rating1 !='' && rating1 != null) {
            rating  = decimal.Valueof(rating1);
        }
        else{
            rating = 0;
        }
       
        if(yrsofexp1 !='' && yrsofexp1 != null) {
            yrsofexp  = decimal.Valueof(yrsofexp1);
        }
        else{
            yrsofexp = 0;
        }
      
        string t1='\'';
        string t2= '\'';
        
       
        
       
         if((area =='' || area == null) && ( yrsofexp < 1) && (expertise =='' || expertise == null) && /*(education =='' || education == null) &&*/ (residence =='' || residence == null) && (status =='' || status == null) && rating < 1 && 
         	(fName == '' || fName == null) && (lName == '' || lName == null) && (email == '' || email == null) && (personId == '' || personId == null) && (highestEdu == '' || highestEdu == null))
        {
             soql = 'select Id,Name,firstname,lastname,Email,Area_of_Expertise__c,Expertise__c ,Years_of_Experience__c,Highest__c,perSequence__c,Performance_Rating__c,State_of_Residence__c,Status__c from contact where  status__c=\'Accepted\' and RecordType.Name =\'Expert Reviewer\'';     
        }
        else
        {
            soql = 'select Id,name,firstname,lastname,Email,Area_of_Expertise__c,Expertise__c ,Years_of_Experience__c,Highest__c,perSequence__c,Performance_Rating__c,State_of_Residence__c,Status__c from contact where  status__c=\'Accepted\' and RecordType.Name =\'Expert Reviewer\'' ;
            if (!fName.equals(''))
                soql += ' AND FirstName = '+t1+fName+t2;
            if (!lName.equals(''))
                soql += ' AND LastName = '+t1+lName+t2;
            if (!email.equals(''))
                soql += ' AND Email = '+t1+email+t2;
            if (!personId.equals(''))
                soql += ' AND perSequence__c = '+t1+pId+t2;                                          
            /*if (!education.equals(''))
                soql += 'AND  Highest__c = '+t1+education+t2;*/
      		if (!highestEdu.equals(''))
                soql += ' AND Highest__c = '+t1+highestEdu+t2;                 
            if (!status.equals(''))
                soql += ' AND Status__c = '+t1+status+t2;
                
             if (!residence.equals('')){
             	/*String[] tmpList = residence.split(',');
             	if(tmpList.size()==1){
             		soql += ' AND State_of_Residence__c = '+t1+tmpList[0]+t2;
             	}
             	if(tmpList.size()>1){
             		soql += 'AND ';             	
             		for(String s: tmpList){
             			soql += ' (State_of_Residence__c = '+t1+s+t2+' OR ';
             		}
             	}*/             	
             }
                      
            if (!area.equals(''))
                soql += ' AND Area_of_Expertise__c = '+t1+area+t2;                
            if (!expertise.equals(''))
                soql += ' AND Expertise__c = '+t1+expertise+t2;
            
            
            if(rating <1) {
                soql+='';
            }
            else {
                soql += ' AND Performance_Rating__c= '+rating;
            }
            
            if(yrsofexp <1) {
                soql+='';
            }
            else {
                soql += ' AND Years_of_Experience__c= '+yrsofexp;
            }
       
           system.debug('**************************************query'+soql);
            debugsoql = soql;
           
           
            //return wrappedContacts;
            
        
        }    
        
        if(lContacts.size()>0)
                lContacts.clear();
        lContacts = new list<Contact>();
        lContacts = database.query(soql);
            
        if(wrappedContacts.size()==0) {
            wrappedContacts = new List<contactWrapper>();  
            for(Contact c: lContacts){
                wrappedContacts.add(new contactWrapper(c));
            }                     
        }
        else if(wrappedContacts.size()>0){
            wrappedContacts.clear();
            wrappedContacts = new List<contactWrapper>();  
            for(Contact c: lContacts){
                wrappedContacts.add(new contactWrapper(c));
            }               
        }   
                
    }
    
    public class contactWrapper{
        public Contact con{get;set;}        
        public Boolean isSelected{get;set;}     
        
        public contactWrapper(Contact c) {
            con = c;
            isSelected = false;

        }
    }           
    
    public PageReference savePanelMembers(){
        list<Reviewer_Pool__c> newpanelMembers = new list<Reviewer_Pool__c>();
        set<Id> selectedContactIds = new set<Id>();
        for(ContactWrapper c: wrappedContacts){
            if(c.isSelected){
                selectedContactIds.add(c.con.Id);
            }
        }
        map<String,Reviewer_Pool__c> existingMembersMap = new map<String,Reviewer_Pool__c>();
        list<Reviewer_Pool__c> existingPanelMembers = new list<Reviewer_Pool__c>([Select Id,Expert_Reviewer_Name__c,NOFA_Group__c from Reviewer_Pool__c ]);
        for(Reviewer_Pool__c pm: existingPanelMembers){
            existingMembersMap.put(String.valueOf(pm.Expert_Reviewer_Name__c)+String.valueOf(pm.NOFA_Group__c),pm);
        }
        
        if(selectedContactIds.size()>0){
            for(Id i: selectedContactIds){
                String key = String.valueOf(i)+String.valueOf(panel.Id);
                system.debug('key = '+key);
                system.debug('map = '+existingMembersMap);
                if(existingMembersMap.get(key) == null){
                    Reviewer_Pool__c pm = new Reviewer_Pool__c();
                    pm.Expert_Reviewer_Name__c = i;
                    pm.NOFA_Group__c = ApexPages.currentPage().getParameters().get('id');
                    pm.Status__c = 'Active';
                    // pm.Reviewer__c = 
                    newpanelMembers.add(pm);
                }
            }
        }
        
        if(newpanelMembers.size()>0){
            insert newpanelMembers;
        }
        PageReference pg = new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
        return pg;
    }
    
    public PageReference cancel(){
        PageReference pg = new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
        return pg;
    }
	
	public List<SelectOption> stateslist{
		set;
		get{
			Schema.DescribeFieldResult Industryvalues = contact.State_of_Residence__c.getDescribe();

   		    List<Schema.PicklistEntry> Industryvalueslist = Industryvalues.getPicklistValues();

   		    List<SelectOption> options = new List<SelectOption>();
   			for(Schema.PicklistEntry c:Industryvalueslist)
   		    {

   			 System.debug('@@@@4'+c.getValue());    

    		 options.add(new SelectOption(c.getValue(),c.getValue())); 
		    }
		    return options;
		}
	}
	
	public List<SelectOption> expertiselist{
		set;
		get{
			Schema.DescribeFieldResult Industryvalues = contact.Expertise__c.getDescribe();

   		    List<Schema.PicklistEntry> Industryvalueslist = Industryvalues.getPicklistValues();

   		    List<SelectOption> options = new List<SelectOption>();
   			for(Schema.PicklistEntry c:Industryvalueslist)
   		    {

   			 System.debug('@@@@4'+c.getValue());    

    		 options.add(new SelectOption(c.getValue(),c.getValue())); 
		    }
		    return options;
		}
	}
	
	public List<SelectOption> areaofexpertiselist{
		set;
		get{
			Schema.DescribeFieldResult Industryvalues = contact.Area_of_Expertise__c.getDescribe();

   		    List<Schema.PicklistEntry> Industryvalueslist = Industryvalues.getPicklistValues();

   		    List<SelectOption> options = new List<SelectOption>();
   			for(Schema.PicklistEntry c:Industryvalueslist)
   		    {

   			 System.debug('@@@@4'+c.getValue());    

    		 options.add(new SelectOption(c.getValue(),c.getValue())); 
		    }
		    return options;
		}
	}
	
    /*String[] countries = new String[]{};
    List<String> pickValues=new List<String>();
    
    String[] countries1 = new String[]{};
    List<String> pickValues1=new List<String>();
    
    String[] countries2 = new String[]{};
    List<String> pickValues2=new List<String>();
    
    public String[] getCountries() {
    return countries;
    }
     
    public String[] getCountries1() {
    return countries1;
    }

    public String[] getCountries2() {
    return countries2;
    }
    
    public void setCountries(String[] countries) {
    this.countries = countries;
    }
    
     public void setCountries1(String[] countries1) {
    this.countries = countries1;
    }
    
     public void setCountries2(String[] countries2) {
    this.countries = countries2;
    }
    public List<SelectOption> getdoWork(){

    Schema.DescribeFieldResult Industryvalues = contact.Area_of_Expertise__c.getDescribe();

    List<Schema.PicklistEntry> Industryvalueslist = Industryvalues.getPicklistValues();

    List<SelectOption> options = new List<SelectOption>();
    for(Schema.PicklistEntry c:Industryvalueslist)
    {

    System.debug('@@@@4'+c.getValue());    

    options.add(new SelectOption(c.getValue(),c.getValue())); 

    }

    return options;
    }
    public List<SelectOption> getdoWork1(){

    Schema.DescribeFieldResult Industryvalues = contact.Expertise__c.getDescribe();

    List<Schema.PicklistEntry> Industryvalueslist = Industryvalues.getPicklistValues();

    List<SelectOption> options1 = new List<SelectOption>();
    for(Schema.PicklistEntry c:Industryvalueslist)
    {

    System.debug('@@@@4'+c.getValue());    

    options1.add(new SelectOption(c.getValue(),c.getValue())); 

    }

    return options1;
    }
    public List<SelectOption> getdoWork2(){

    Schema.DescribeFieldResult Industryvalues = contact.State_of_Residence__c.getDescribe();

    List<Schema.PicklistEntry> Industryvalueslist = Industryvalues.getPicklistValues();

    List<SelectOption> options2 = new List<SelectOption>();
    for(Schema.PicklistEntry c:Industryvalueslist)
    {

    System.debug('@@@@4'+c.getValue());    

    options2.add(new SelectOption(c.getValue(),c.getValue())); 

    }

    return options2;
    }*/

    
}