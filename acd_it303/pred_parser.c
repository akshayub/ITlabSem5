#include<stdio.h>
#include<ctype.h>
struct firtable
{
	int n;
	char firtable[10];
};
struct foltable
{
	int n;
	char foltable[10];
};
struct foltable follow[10];
struct firtable first[10];
char arr[10][10];
int col,p=0;
void followOp(char ch,int pos){   
	int i,j;
    	for(i=0;i<10;i++){
        	if(ch == follow[i].foltable[0]){
            		for(j=1;j<=follow[i].n;j++){
                		follow[pos].foltable[col] = follow[i].foltable[j];
                		col++;
                		follow[pos].n++;
            		}
        	}
    	}   
}
void firstOp(char ch,int pos){   
	int i,j;
	for(i=0;i<10;i++){
        	if(ch == first[i].firtable[0]){
            		for(j=1;j<=first[i].n;j++){
                		if(first[i].firtable[j] != '0'){
                    			follow[pos].foltable[col] = first[i].firtable[j];
                    			follow[pos].n++;
                    			col++;                  
                		}
                		else{
                    			followOp(ch,pos);
                		}
            		}
        	}
    	}
}
void fFirst(char ch,int pos){
	int i;
	for(i=0;i<p;i++){
        	if(ch ==arr[i][0]){
            		if(isupper(arr[i][3])){
                		fFirst(arr[i][3],pos);
            		}
            		else{
       				first[pos].firtable[col]=arr[i][3];
        			first[pos].n++;
        			col++;
         		}
        	}
    	}
}
void fFollow(char ch,int pos){   
	int i,j;
    	if(pos==0 && col==1){
        	follow[pos].foltable[col]= '$';
        	col++;
        	follow[pos].n++;
    	}
    	for(i=0;i<p;i++){
        	for(j=3;j<=p;j++){
            		if(arr[i][j] == ch){
                		if(arr[i][j+1] == '\0'){
                    			if(arr[i][j] != arr[i][0]){
                        			followOp(arr[i][0],pos);
                    			}
                		}
                		else if(isupper(arr[i][j+1])){   
					if(arr[i][j+1]!=arr[i][0]){
                        			firstOp(arr[i][j+1],pos);                                     
		    			}
                		}
                		else{
                    			follow[pos].foltable[col] = arr[i][j+1];  
                    			col++;
                    			follow[pos].n++;           
                		}   
            		}
        	}
    	}   
}
void main()
{
    	int i,j,flag=0,count=0,pro,k;
    	char t[10],ch;
    	printf("Enter number of productions: ");
    	scanf("%d",&pro); 
    	p=pro;
    	printf("\nEnter %d productions\n",p);
    	for(i=0;i<p;i++){
    		scanf("%s",arr[i]);  
    	}
    	for(i=0;i<p;i++){   
		flag=0;
    		for(j=0;j<i+1;j++){
        		if(arr[i][0] == t[j]){
           			 flag=1;    
            			 break;
        		}    
    		}
    		if(flag!=1){
      			t[count] = arr[i][0];
      			count++;
    		}               
    	}
    	for(i=0;i<count;i++){   
		col=1;
    		first[i].firtable[0] = t[i];
    		first[i].n=0;
    		fFirst(t[i],i);
    	}
    	for(i=0;i<count;i++){
    		col=1;
    		follow[i].foltable[0] = t[i];
    		follow[i].n=0;
    		fFollow(t[i],i);
     	}
   	for(i=0;i<count;i++){
    		for(j=0;j<=first[i].n;j++){
            		if(j==0){
                		printf("FIRST(%c): ",first[i].firtable[j]);
            		}
            		else{   
               			 printf("%c ",first[i].firtable[j]);
           		}
    		}
    		printf("\n");
    	} 
     	printf("\n");
   	for(i=0;i<count;i++){
    		for(j=0;j<=follow[i].n;j++){
            		if(j==0){
                		printf("FOLLOW(%c): ",follow[i].foltable[j]);
            		}
            		else{   
                		printf("%c ",follow[i].foltable[j]);
           		}
    		}
   		 printf("\n");
    	} 
    	for(i=0;i<p;i++){
		if(isupper(arr[i][3])){
			for(j=0;j<10;j++){
				if(arr[i][3]==first[j].firtable[0]){
					for(k=1;k<=first[j].n;k++){
						printf("M[%c,%c]: %s\n",arr[i][0],first[j].firtable[k],arr[i]);	
					}
				}
			}
		}
		else if(arr[i][3]=='0'){
			for(j=0;j<10;j++){
				if(arr[i][0]==follow[j].foltable[0]){
					for(k=1;k<=follow[j].n;k++)
						printf("M[%c,%c]: %s\n",arr[i][0],follow[j].foltable[k],arr[i]);
				}
			}			
		}
		else if(isalnum(arr[i][3]))	
			printf("M[%c,%c]:%s\n",arr[i][0],arr[i][3],arr[i]);
		else 
			printf("M[%c,%c]:%s\n",arr[i][0],arr[i][3],arr[i]);
		}

}
// Source : https://gist.github.com/Pooja269/19901796c5172afa267c2fa6422339e4
