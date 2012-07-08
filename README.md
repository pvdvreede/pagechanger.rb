# pagechanger

### File alteration bot for programmatically altering large amount of files with Regular Expressions

pagechanger can be used to search through text based files and make change to the text by adding, deleting, changing or a combination of all three.

This is done using a config file to tell page-changer what to alter in what file type. So that the process can be rerun over multiple files, multiple times.

#### Installation

TBA

#### Usage

pagechanger uses a YAML config file that you specify as a command line argument to know what files to change.

The format of the config file is:

      - name: <name of the set>
        mask: <file mask of what files to alter>
        criteria: 
        - <list of strings or reg ex that must be present in the file for it to be processed>
        exceptions:
        - <list of filenames (without paths) that match the criteria but you want to ignore explicitly>
        remove:
            - <reg ex to remove from line>              
        replace: 
            - find: <text to that will be replaced use %rep%>
              replace: <text to replace>
                
      - name: ... <put n or more parser sets, to parse different file types, or alterations required>

An example file would be:

    - name: html
      criteria: 
      - findme
      exceptions:
      - dontchangeme.txt
      mask: 'Search.html'
      remove:
      - '<head>'
      - '<html xmlns="http://www.w3.org/1999/xhtml">'
      - '</head>'
      - '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
      - '</html>'
      - '</body>'
      - '<body>'
      replace:
      - find: 'colou*r'
        replace: 'something else'

To run the config over a set of files use the command line tool:

    TBA
    
Here are the command line options and arguments:

    TBA