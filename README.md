# Moon

## Getting Started

1. Run the bootstrap script to check system dependencies:

   ```console
   script/bootstrap.sh
   ```

## Dependencies
* ruby (check [.ruby-version](https://github.com/Bidu/simba/blob/master/.ruby-version))
* postgres >= 9.1

## Tests

## Heroku
Moon uses heroku for its environments and for such the heroku script should be used

   ```console
   script/heroku.sh configure
   ```
   
Configure heroku enviroments

   ```console
   script/heroku.sh push ENV
   ```
   
Pushes branch to env
