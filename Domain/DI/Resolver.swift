//
//  Resolver.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import Swinject

public let assembler = Assembler(container: container)
public let container = Container()

public extension Resolver {
    
    func resolve<T>() -> T {
        return resolve(T.self)!
    }
    
    func resolve<T, Arg>(argument arg: Arg) -> T {
        return resolve(T.self, argument: arg)!
    }
    
    func resolve<T, Arg1, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) -> T {
        return resolve(T.self, arguments: arg1, arg2)!
    }
    
    func resolve<T, Arg1, Arg2, Arg3>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T {
        return resolve(T.self, arguments: arg1, arg2, arg3)!
    }
    
    func resolve<T, Arg1, Arg2, Arg3, Arg4>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> T {
        return resolve(T.self, arguments: arg1, arg2, arg3, arg4)!
    }
    
    func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> T {
        return resolve(T.self, arguments: arg1, arg2, arg3, arg4, arg5)!
    }
    
    func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> T {
        return resolve(T.self, arguments: arg1, arg2, arg3, arg4, arg5, arg6)!
    }
    
    func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> T {
        return resolve(T.self, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7)!
    }
    
    func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> T {
        return resolve(T.self, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)!
    }
    
func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> T {
        return resolve(T.self, arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)!
    }
}

public func register(assembly: Assembly) {
    assembler.apply(assembly: assembly)
}

public func register(assemblies: [Assembly]) {
    assembler.apply(assemblies: assemblies)
}

public func resolve<T>() -> T {
    return assembler.resolver.resolve()
}

public func resolve<T, Arg>(argument: Arg) -> T {
    return assembler.resolver.resolve(argument: argument)
}

public func resolve<T, Arg1, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) -> T {
    return assembler.resolver.resolve(arguments: arg1, arg2)
}

public func resolve<T, Arg1, Arg2, Arg3>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T {
    return assembler.resolver.resolve(arguments: arg1, arg2, arg3)
}

public func resolve<T, Arg1, Arg2, Arg3, Arg4>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> T {
    return assembler.resolver.resolve(arguments: arg1, arg2, arg3, arg4)
}

public func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> T {
    return assembler.resolver.resolve(arguments: arg1, arg2, arg3, arg4, arg5)
}

public func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6) -> T {
    return assembler.resolver.resolve(arguments: arg1, arg2, arg3, arg4, arg5, arg6)
}

public func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7) -> T {
    return assembler.resolver.resolve(arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7)
}

public func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8) -> T {
    return assembler.resolver.resolve(arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
}

public func resolve<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5, _ arg6: Arg6, _ arg7: Arg7, _ arg8: Arg8, _ arg9: Arg9) -> T {
    return assembler.resolver.resolve(arguments: arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
}

