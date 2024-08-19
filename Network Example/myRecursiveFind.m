= (inputTable as table, signalID as any, nodeID as any, findType as text) =>
let
    #"filteredTable" = Table.Distinct(myFilter(inputTable, signalID, nodeID, findType)),
    #"filteredRecord" = Table.SingleRow(#"filteredTable"),
    tableType = if Text.Contains(findType, "Destination", Comparer.OrdinalIgnoreCase) then true else false,
    result = if tableType then 
                if (#"filteredRecord"[Sources.Endpoint] = true) then
                    #"filteredTable"
                else
                    myRecursiveFind(inputTable, signalID, #"filteredRecord"[Source ID], findType)
            else
                if (#"filteredRecord"[Destinations.Endpoint] = true) then
                    #"filteredTable"
                else
                    myRecursiveFind(inputTable, signalID, #"filteredRecord"[Destination ID], findType)
in
    result