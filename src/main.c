#include <check.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <uv.h>
#include <zlib.h>

int main(int argc, char *argv[]) {
  printf("Hello, World!");
  char command[100], msg[100];

  strcpy(command, "notify-send ");
  strcpy(msg, "\"Hello World\"");
  strcat(command, msg);

  system(command);
  return 0;
}
