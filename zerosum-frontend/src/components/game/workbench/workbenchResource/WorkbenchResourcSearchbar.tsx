import { SearchIcon } from "@chakra-ui/icons"
import { Input, InputGroup, InputLeftElement } from "@chakra-ui/react"

export const WorkbenchResourceSearchbar = ({ setSearchTerm }: { setSearchTerm: (searchTerm: string) => void }) => {
    return (
        <InputGroup py={1} mb={8}>
            <InputLeftElement mt={1} pointerEvents='none'>
                <SearchIcon color='gray.300' />
            </InputLeftElement>
            <Input
                letterSpacing={1}
                fontFamily={"Orbitron"}
                placeholder='Search...'
                color={"samaWhite"}
                boxShadow="inset 0px 0px 10px rgba(0, 0, 0, 0.5)"
                borderColor={"samaWhite"}
                _focus={{ borderColor: "samaTeal.500" }}
                onChange={(e) => setSearchTerm(e.target.value.toLowerCase())}
            />
        </InputGroup>
    )
}
