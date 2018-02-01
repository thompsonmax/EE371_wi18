/*
    File Name: convert.c
    Description: Currency Calculator that gets the currency and amount that a
        user wants to convert and displays the converted amount and the amount
        of beers that the user can purchase with the amount given
    Author(s): Varun Venkatesh, Max Thompson, Akhil Avula
*/

//  preprocessor directive to support printing to the display
#include <stdio.h>

#define NUM_CURR 6

//  the main program
int main(void) {
  //  declare, define, and initialize  working variables
  int user_select = -1;
  // Euros, Pounds,Yen,Rupees,Pesos,Zimbabwe Dollars
  double balance[NUM_CURR] = {0.82, 0.73, 111.13, 63.60, 18.99, 361.9};
  double beer_conversion[NUM_CURR] = {0.82, 3, 235, 220, 25, 542.85};
  char *curr_names[NUM_CURR] = {"Euros", "Pounds", "Yen", "Rupees", "Pesos", "Zimbabwe Dollars"};
  float convert = 0.0;
  float end_money = 0.0;
  float beers = 0.0;
  int i = 0;

  // Ask User what Currency they would like to exchange to
  printf("Welcome to the Currency Calculator!\n");
  printf("What Currency do you want the exchange rate for? (As of 1/14/2018 2:50 pm PST)\n");

  // print out all of the currency options
  while (i < NUM_CURR) {
    printf("%d. %s\n", i, curr_names[i]);
    i++;
  }

  // Ask the user for what currency they want
  // only accepts options within the correct range (0 -> 5)
  while (user_select > 5 || user_select < 0) {
    printf("\nPlease enter your choice\n");

    // get the data from the user
    // the data will be a floating point number: %f
    // stored in the variable 'a'
    // the & operator takes the address of the variable 'a'
    scanf("%d", &user_select);

    //  remove newline from input buffer
    getchar();
  }

  // Print exchange rate of that choice
  printf("\nThe exchange rate is currently %2.2lf %s per Dollar.\n\n", balance[user_select], curr_names[user_select]);

  // Gets the amount the user wants to convert
  printf("Please enter the amount you wish to convert.\n");
  scanf("%f", &convert);
  getchar();

  // Calculates the converted amount based on the user's inputs of currency and amount
  end_money = convert * balance[user_select];
  // prints the converted amount
  printf("You now have %2.2lf %s.\n", end_money, curr_names[user_select]);
  // calculates the amount of beer the user can buy based on the converted amount and gives information to user
  beers = end_money / beer_conversion[user_select];
  printf("You can buy %2.2lf beers.\n", beers);

  // EXIT SUCCESS
  return 0;
}
