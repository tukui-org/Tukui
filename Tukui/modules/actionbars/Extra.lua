local T, C, L = unpack(select(2, ...))
if T.toc < 40300 then return end

-- We never use MainMenuBar, so we need to parent this frame outside of it else it will not work.
ExtraActionBarFrame:SetParent(UIParent)