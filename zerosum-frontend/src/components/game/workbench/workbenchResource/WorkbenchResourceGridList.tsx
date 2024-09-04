import { Box } from "@chakra-ui/react";
import { WorkbenchResourceGrid } from "./WorkbenchResourceGrid";
import { WorkbenchResourceItem } from "./WorkbenchResourceItem";

type WorkbenchResourceGridListProps = {
    searchTerm: string
    setSelectedItem: (selectedItem: Workbench.Craftable) => void
    selectedItem: Workbench.Craftable | null
    schematics: Workbench.Craftable[]
    resources: Workbench.Craftable[]
    tokenBalances: SquidBalancesResponse | undefined
}

export const WorkbenchResourceGridList = ({ searchTerm, setSelectedItem, selectedItem, schematics, resources, tokenBalances }: WorkbenchResourceGridListProps) => {

    const MOCK_RESPONSE = {
        schematics: schematics,
        resources: resources,
    };

    const renderedCategories = Object.entries(MOCK_RESPONSE).map(([key, categoryItemList], index) => {
        if(categoryItemList){
            const filteredItems = categoryItemList?.filter(item =>
                item.name.toLowerCase().includes(searchTerm)
            );

            return filteredItems.length ? (
                <WorkbenchResourceGrid key={`${key}_${index}`} label={key}>
                    {filteredItems.map((item, index) => (
                        <WorkbenchResourceItem
                            key={`${item.blueprint}_${index}`}
                            {...item}
                            onClick={() => setSelectedItem(item)}
                            selection={selectedItem ?? null}
                            tokenBalances={tokenBalances}
                        />
                    ))}
                </WorkbenchResourceGrid>
            ) : null;
        }
    });

    return (
        <>
            {renderedCategories}
            {renderedCategories.every(category => !category) && <PlaceholderGrid />}
        </>
    );
};

const PlaceholderGrid = () => {
    return (
        <Box
            visibility={"hidden"}
            opacity={0}
            pointerEvents={"none"}
        >
            <WorkbenchResourceGrid label={""}>
                <Box h={20} w={20} />
            </WorkbenchResourceGrid>
        </Box>
    );
};
