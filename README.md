# Project: Direct Mapped Cache
# Contributers: Daniel Giro, Ian Lane
## Introduction
This project is direct mapped cache created in VHDL with schematics and layouts.

## Notes                                  
```bash
                                         ______________________     
dff -> reg -> 4byte_reg -> cache_mem --->|                    |
                                         |    Chip (Cache)    |
hit_miss_logic -> state_machine -------->|                    |
                                         ______________________
```
