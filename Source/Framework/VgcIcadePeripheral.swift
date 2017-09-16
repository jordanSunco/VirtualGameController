//
//  VgcIcadeMappings.swift
//  VirtualGameControllerTvOS
//
//  Created by Rob Reuss on 10/24/15.
//  Copyright © 2015 Rob Reuss. All rights reserved.
//

import Foundation

#if !os(watchOS)

public enum IcadeControllerMode: CustomStringConvertible {
 
    case disabled
    case snakebyteIdroidCon
    case steelSeriesFree
    case iCade
    case iCadeMobile
    case iCadeJr
    case eightbitty
    case gametel
    case iControlPadEarly
    case iControlPadLate
    case gameDock
    case iMpulse
    case nyko
    
    public var description : String {
        
        switch self {
        case .disabled: return "iCade Support Disabled"
        case .snakebyteIdroidCon: return "Snakebyte iDroid:con"
        case .steelSeriesFree: return "SteelSeries Free"
        case .iCade: return "iCade"
        case .iCadeMobile: return "iCade Mobile"
        case .iCadeJr: return "iCade Jr."
        case .eightbitty: return "8-bitty"
        case .gametel: return "Gametel"
        case .iControlPadEarly: return "iControlPad (2.1a, 2.3)"
        case .iControlPadLate: return "iControlPad (2.4)"
        case .gameDock: return "GameDock"
        case .iMpulse: return "iMpulse"
        case .nyko: return "Nyko PlayPad / Pro"
            
        }
    }
}

open class VgcIcadePeripheral: NSObject {
    
    let peripheralManager = VgcManager.peripheral
    
    ///
    /// Return an element in exchange for a character sent by the iCade controller.
    ///
    /// - parameter characterString: The character received through a text field in response to an end-user action on an iCade controller.
    /// - parameter controllerElements: The population of elements that the correct element for the given iCade character should be identified from.  
    /// For Central/Bridge-based controller implementations, this will be VgcController.iCadeController.elements.  For Peripheral-based implementations,
    /// it will be the global population of elements contained in VgcManager.elements.  
    ///
    open func elementForCharacter(_ characterString: String, controllerElements: Elements) -> (Element?, Int) {
        
        let elementCharacter = characterString.uppercased()
        
        // Handle dpad, which is common to known iCade controllers
        if "WEXZDCAQ".range(of: elementCharacter) != nil {
            return standardDpad(elementCharacter, controllerElements: controllerElements)
            
        }
        
        switch VgcManager.iCadeControllerMode {
            
        case .disabled:
            return (nil, 0)
            
        case .snakebyteIdroidCon: // DONE
            
            switch elementCharacter {
                
                // A/B/X/Y Buttons
            case "Y":
                return (controllerElements.buttonY, 1)
            case "T":
                return (controllerElements.buttonY, 0)
                
            case "J":
                return (controllerElements.buttonX, 1)
            case "N":
                return (controllerElements.buttonX, 0)
                
            case "U":
                return (controllerElements.buttonA, 1)
            case "F":
                return (controllerElements.buttonA, 0)
                
            case "H":
                return (controllerElements.buttonB, 1)
            case "R":
                return (controllerElements.buttonB, 0)
                
                // Shoulders
            case "K":
                return (controllerElements.rightShoulder, 1)
            case "P":
                return (controllerElements.rightShoulder, 0)
                
            case "I":
                return (controllerElements.leftShoulder, 1)
            case "M":
                return (controllerElements.leftShoulder, 0)
                
                // Triggers
            case "O":
                return (controllerElements.rightTrigger, 1)
            case "G":
                return (controllerElements.rightTrigger, 0)
                
            case "L":
                return (controllerElements.leftTrigger, 1)
            case "V":
                return (controllerElements.leftTrigger, 0)
                
            default:
                
                break
                
            }
            
        case .iCadeMobile: // DONE
            
            switch elementCharacter {
                
            case "U","F","Y","T","H","R","J","N":
                return set5678ABXYButtons(elementCharacter, controllerElements: controllerElements)
                
            case  "I","M","K","P","L","V","O","G":
                return set09E1E2ShouldersAndTriggers(elementCharacter, controllerElements: controllerElements)
                
            default: break
            }
            
        case .steelSeriesFree: // DONE
            
            switch elementCharacter {
                
            case "U","F","Y","T","H","R","J","N":
                return set5678ABXYButtons(elementCharacter, controllerElements: controllerElements)
                
            case "I","M","K","P","L","V","O","G":
                return set09E1E2ShouldersAndTriggers(elementCharacter, controllerElements: controllerElements)
                
            default: break
                
            }
            
        case .iCadeJr: // DONE
            switch elementCharacter {
                
            case "U","F","Y","T","H","R","J","N":
                return set5678ABXYButtons(elementCharacter, controllerElements: controllerElements)
                
            case "I","M","K","P","L","V","O","G":
                return set09E1E2ShouldersAndTriggers(elementCharacter, controllerElements: controllerElements)
                
            default: break
            }
            
            
        case .iCade: // DONE
            switch elementCharacter {
                
            case "U","F","Y","T","H","R","J","N":
                return set5678ABXYButtons(elementCharacter, controllerElements: controllerElements)
                
            case "I","M","K","P","L","V","O","G":
                return set09E1E2ShouldersAndTriggers(elementCharacter, controllerElements: controllerElements)
                
            default: break
            }
            
        case .iControlPadLate: // DONE
            switch elementCharacter {
                
            case "U","F","Y","T","H","R","J","N":
                return set5678ABXYButtons(elementCharacter, controllerElements: controllerElements)
                
            case "I","M","K","P","L","V","O","G":
                return set09E1E2ShouldersAndTriggers(elementCharacter, controllerElements: controllerElements)
                
            default: break
            }
            
            
        case .eightbitty:
            switch elementCharacter {
                
            case "I","M","K","P","L","V","O","G":
                return set09E1E2ABXYButtons(elementCharacter, controllerElements: controllerElements)
                
            case "Y","T","H","R","U","F","J","N":
                return set5678ShouldersAndTriggers(elementCharacter, controllerElements: controllerElements)
                
            default: break
            }
            
        case .gametel:
            switch elementCharacter {
                
            case "I","M","K","P","L","V","O","G":
                return set09E1E2ABXYButtons(elementCharacter, controllerElements: controllerElements)
                
            case "Y","T","H","R","U","F","J","N":
                return set5678ShouldersAndTriggers(elementCharacter, controllerElements: controllerElements)
                
            default: break
            }
            
        case .iControlPadEarly:
            switch elementCharacter {
                
            case "I","M","K","P","L","V","O","G":
                return set09E1E2ABXYButtons(elementCharacter, controllerElements: controllerElements)
                
            case "Y","T","H","R","U","F","J","N":
                return set5678ShouldersAndTriggers(elementCharacter, controllerElements: controllerElements)
                
            default: break
            }
            
        default:
            break
            
        }
        return (nil, 0)
    }
}

func standardDpad(_ elementCharacter: String, controllerElements: Elements) -> (Element?, Int) {
    
    switch elementCharacter {
        
        // dpad Y axis
    case "W":
        return (controllerElements.dpadYAxis, 1)
    case "E":
        return (controllerElements.dpadYAxis, 0)
        
    case "X":
        return (controllerElements.dpadYAxis, -1)
    case "Z":
        return (controllerElements.dpadYAxis, 0)
        
        
        // dpad X axis
    case "D":
        return (controllerElements.dpadXAxis, 1)
    case "C":
        return (controllerElements.dpadXAxis, 0)
        
    case "A":
        return (controllerElements.dpadXAxis, -1)
    case "Q":
        return (controllerElements.dpadXAxis, 0)
        
    default:
        return (nil, 0)
    }
}

func set09E1E2ABXYButtons(_ elementCharacter: String, controllerElements: Elements) -> (Element?, Int) {
    
    switch elementCharacter {
        
        // A/B/X/Y Buttons
    case "I":
        return (controllerElements.buttonY, 1)
    case "M":
        return (controllerElements.buttonY, 0)
        
    case "K":
        return (controllerElements.buttonX, 1)
    case "P":
        return (controllerElements.buttonX, 0)
        
    case "L":
        return (controllerElements.buttonA, 1)
    case "V":
        return (controllerElements.buttonA, 0)
        
    case "O":
        return (controllerElements.buttonB, 1)
    case "G":
        return (controllerElements.buttonB, 0)
        
    default:
        return (nil, 0)
    }
    
}

func set09E1E2ShouldersAndTriggers(_ elementCharacter: String, controllerElements: Elements) -> (Element?, Int) {
    
    switch elementCharacter {
        
    case "K":
        return (controllerElements.rightShoulder, 1)
    case "P":
        return (controllerElements.rightShoulder, 0)
    case "L":
        return (controllerElements.rightTrigger, 1)
    case "V":
        return (controllerElements.rightTrigger, 0)
        
    case "I":
        return (controllerElements.leftShoulder, 1)
    case "M":
        return (controllerElements.leftShoulder, 0)
        
    case "O":
        return (controllerElements.leftTrigger, 1)
    case "G":
        return (controllerElements.leftTrigger, 0)
        
    default:
        return (nil, 0)
    }
    
}

func set5678ShouldersAndTriggers(_ elementCharacter: String, controllerElements: Elements) -> (Element?, Int) {
    
    switch elementCharacter {
        
    case "Y":
        return (controllerElements.leftTrigger, 1)
    case "T":
        return (controllerElements.leftTrigger, 0)
    case "H":
        return (controllerElements.leftShoulder, 1)
    case "R":
        return (controllerElements.leftShoulder, 0)
        
    case "U":
        return (controllerElements.rightTrigger, 1)
    case "F":
        return (controllerElements.rightTrigger, 0)
    case "J":
        return (controllerElements.rightShoulder, 1)
    case "N":
        return (controllerElements.rightShoulder, 0)
        
    default:
        return (nil, 0)
    }
    
}

func set5678ABXYButtons(_ elementCharacter: String, controllerElements: Elements) -> (Element?, Int) {
    
    switch elementCharacter {
        
        // A/B/X/Y Buttons
    case "U":
        return (controllerElements.buttonY, 1)
    case "F":
        return (controllerElements.buttonY, 0)
        
    case "Y":
        return (controllerElements.buttonX, 1)
    case "T":
        return (controllerElements.buttonX, 0)
        
    case "H":
        return (controllerElements.buttonA, 1)
    case "R":
        return (controllerElements.buttonA, 0)
        
    case "J":
        return (controllerElements.buttonB, 1)
    case "N":
        return (controllerElements.buttonB, 0)
        
    default:
        return (nil, 0)
    }
}

#endif
