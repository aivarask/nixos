#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
  char command[100], msg[100];

  strcpy(command, "notify-send ");
  strcpy(msg, "\"Hello World\"");
  strcat(command, msg);

  system(command);
  return 0;
}
