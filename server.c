#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXIMUM_NUMBER_OF_CONNECTIONS 64
#define MAX_SIZE_BUFFER 255

int initializate_server(char* user, char* pass, int * port,char * path, char * default_file){
	
	/* pointer to config file */
	FILE *server_cfg_file;

	/* define the max size of the buffer*/
	char buffer[MAX_SIZE_BUFFER];

	/* open file, read only */
	server_cfg_file=fopen("./server.cfg","r");
    if (server_cfg_file==NULL){
        printf("ERROR opening server config file - path := %s \n",default_file);
        return -1;
    }

    /* example of config file:
		user
		pass
		8181
		./site/
		index.html
    */

	/* get user from cfg file */
	fscanf(server_cfg_file,"%s", buffer);
	strcpy(user,buffer);
	/* get password from cfg file */
	fscanf(server_cfg_file,"%s", buffer);
	strcpy(pass,buffer);
	/* get port from cfg file */
	fscanf(server_cfg_file,"%d", port);
	/* get default path from cfg file */
	fscanf(server_cfg_file,"%s", buffer);
	strcpy(path,buffer);
	/* get by default files that is going to be served from cfg file */
	fscanf(server_cfg_file,"%s", buffer);
	strcpy(default_file,buffer);

	/* close config file*/
	fclose(server_cfg_file);
	return 0;
}

int main(){

	char user[MAX_SIZE_BUFFER];
	char pass[MAX_SIZE_BUFFER];
	char path[MAX_SIZE_BUFFER];
	char default_file[MAX_SIZE_BUFFER];
	int port;

	initializate_server(user, pass, &port, path, default_file);

	
	/* init vars, check arguments */
	
	/* socket binding */
	
	/* main loop  */
	
	while(1){
		/* create thread */ 
		
	}
	
	/* close threads */
	return 0;
}
