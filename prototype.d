import std.stdio;
import std.conv;
import std.random;
import std.process;

const int maxVal = 1;
const int minVal = 0;
const int arraySize = 8;

void initOneTable(ref int[] tab)
{
    for(int i = 0; i < arraySize; ++i)
        tab ~= uniform(minVal, maxVal + 1);
}

void initTables(ref int[] tab1, ref int [] tab2)
{
    initOneTable(tab1);
    initOneTable(tab2);
}

void writeOneTable(int[] tab)
{
    foreach (key; tab)
        key.write;
    writeln;
}

void writeTables(int[] tab1, int[] tab2)
{
    tab1.writeOneTable;
    tab2.writeOneTable;
}

void shiftLeft(ref int[] myNumber)
{
    int lastNumber, currentNumber;
    for(int i = 0; i < arraySize; ++i)
    {
        currentNumber = myNumber[i];

        if(i == 0)
            myNumber[i] = 0;
        else
            myNumber[i] = lastNumber;
        
        lastNumber = currentNumber;
    }
}

void shiftRight(ref int[] myNumber)
{
   int lastNumber, currentNumber;
    for(int i = arraySize -1; i >= 0; --i)
    {
        currentNumber = myNumber[i];

        if(i == arraySize -1)
            myNumber[i] = 0;
        else
            myNumber[i] = lastNumber;
        
        lastNumber = currentNumber;
    }
}

void addBitLeft(ref int[] myNumber)
{
    int lastNumber, currentNumber;
    for(int i = 0; i < arraySize; ++i)
    {
        currentNumber = myNumber[i];

        if(i == 0)
            myNumber[i] = 1;
        else
            myNumber[i] = lastNumber;
        
        lastNumber = currentNumber;
    }
}

void addBitRight(ref int[] myNumber)
{
    int lastNumber, currentNumber;
    for(int i = arraySize -1; i >= 0; --i)
    {
        currentNumber = myNumber[i];

        if(i == arraySize -1)
            myNumber[i] = 1;
        else
            myNumber[i] = lastNumber;
        
        lastNumber = currentNumber;
    }
}

bool match(int[] tab1, int[] tab2)
{
    for(int i = 0; i < arraySize; ++i)
    {
        if(tab1[i] != tab2[i])
            return false;
    }
    return true;
}
void reset(ref int[] tab1, ref int[] tab2)
{
    for(int i = 0; i < arraySize; ++i)
    {
        tab1[i] = uniform(minVal, maxVal + 1);
        tab2[i] = uniform(minVal, maxVal + 1);
    }
}

void gameLoop()
{
    int[] numberToMatch;
    int[] myNumber;
    bool isDone;

    initTables(numberToMatch, myNumber);
    spawnShell( "cls" ).wait;

    while(!isDone)
    {   
        writeTables(numberToMatch, myNumber);

        if(match(numberToMatch, myNumber))
        {
            writeln("---YOU WIN!!!---");
            write("Try again?(y/n):");

            switch(readln)
            {
                case "y\n":
                    reset(numberToMatch, myNumber);
                    writeTables(numberToMatch, myNumber);
                    break;
                case "n\n":
                    isDone = true;
                    break;
                default:
                    write("Try again?(y/n):");
                    break;
            }
        }

        if(!isDone)
        {
            switch(readln)
            {
                case "sl\n":
                    myNumber.shiftLeft;
                    spawnShell( "cls" ).wait;
                    break;
                case "sr\n":
                    myNumber.shiftRight;
                    spawnShell( "cls" ).wait;
                    break;
                case "addl\n":
                    myNumber.addBitLeft;
                    spawnShell( "cls" ).wait;
                    break;
                case "addr\n":
                    myNumber.addBitRight;
                    spawnShell( "cls" ).wait;
                    break;
                case "help\n":
                    writeln("sl => shift right");
                    writeln("sr => shift left");
                    writeln("exit => stop application");
                    break;
                case "exit\n":
                    isDone = true;
                    break;
                default:
                    writeln("commande not found \ntype 'help' to see list of available commands");
                    break;
            }
        }
    }
}

void startGame()
{
    gameLoop;
}
void main()
{
    startGame;
}
