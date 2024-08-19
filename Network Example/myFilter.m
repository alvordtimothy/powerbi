= (inputTable as table, signalID as any, nodeID as any, filterType as text) => let
        signalFiltered = Table.SelectRows(inputTable, each ([Signal ID] = signalID)),
        nodeFiltered = if Text.Contains(filterType, "Destination", Comparer.OrdinalIgnoreCase) then Table.SelectRows(signalFiltered, each ([Destination ID] = nodeID)) else Table.SelectRows(signalFiltered, each ([Source ID] = nodeID))
    in
        nodeFiltered