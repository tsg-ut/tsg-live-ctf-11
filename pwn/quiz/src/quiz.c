#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

char flag[100];

int do_challenge(int idx, char **problems, char **answers, char **descriptions)
{
  char buf[100];
  printf("\x1b[36mChallenge %d:\x1b[0m %s\nAnswer > ", idx, problems[idx]);
  scanf("%s", buf);
  if (strcmp(answers[idx], buf) == 0)
  {
    puts("\x1b[32mCorrect!\x1b[0m");
    return 1;
  }
  else
  {
    printf("\x1b[31mWrong...\x1b[0m\n%s\n", descriptions[idx]);
    return 0;
  }
}

int main(void)
{
  char *problems[3] = {
      "What is the full name of TSG?",
      "Who is the next leader of TSG CTF?",
      "What is the flag of this challenge?",
  };
  char *answers[3] = {
      "TheoreticalScienceGroup",
      "iwashiira",
      flag};
  char *descriptions[3] = {
      "TSG stands for \"Theoretical Science Group.\" The abbreviation TSG stands for 'Theoretical Science Group.' It is a common misconception that the 'T' refers to the University of Tokyo, but this is not correct.",
      "@hakatashi, who started TSG CTF four years ago and has led the event until now, has stepped down as TSG CTF leader after TSG CTF 2023. The next TSG CTF will be under the direction of @iwashiira, an experienced CTF player.",
      "CTF is a contest where you use magical powers to guess the flag. If you can't answer this question correctly, it seems you still need more training in your magical abilities."};
  int sum = 0;
  for (int i = 0; i < 3; i++)
  {
    sum += do_challenge(i, problems, answers, descriptions);
  }
  printf("\n\nYour score: %d\n", sum);
  return 0;
}

__attribute__((constructor)) void init()
{
  setvbuf(stdin, NULL, _IONBF, 0);
  setvbuf(stdout, NULL, _IONBF, 0);
  int fd = open("flag", 0);
  read(fd, flag, 100);
  close(fd);
}