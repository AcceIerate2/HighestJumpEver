local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Data store setup for tracking purchases that were successfully processed
local purchaseHistoryStore = DataStoreService:GetDataStore("PurchaseHistory")

-- Table setup containing product IDs and functions for handling purchases
local productFunctions = require(script.ProductIds)

-- The core 'ProcessReceipt' callback function
local function processReceipt(receiptInfo)

	-- Check the data store to determine if the product was already granted
	local playerProductKey = receiptInfo.PurchaseId
	local purchased = false
	local success, result, errorMessage

	success, errorMessage = pcall(function()
		purchased = purchaseHistoryStore:GetAsync(playerProductKey)
	end)

	-- If the purchase is recorded, the product was already granted
	if success and purchased then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	elseif not success then
		error("Data store error:" .. errorMessage)
	end

	-- Update the purchase record
	local success, isPurchaseRecorded = pcall(function()
		return purchaseHistoryStore:UpdateAsync(playerProductKey, function(alreadyPurchased)
			if alreadyPurchased then
				return true
			end

			-- Find the player who made the purchase in the server
			local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
			if not player then

				-- The player probably left the game
				-- If the player returns, the callback is called again
				return nil
			end

			local handler = productFunctions[receiptInfo.ProductId]

			ReplicatedStorage.Events.RemoteEvents.Confetti:FireClient(player)

			local success, result = pcall(handler, player)
      
			-- Do not record the purchase if granting the product failed
			if not success or not result then
				error("Failed to process a product purchase for ProductId: " .. tostring(receiptInfo.ProductId) .. " Player: " .. tostring(player) .. " Error: " .. tostring(result))
				return nil
			end

			-- Record the transaction in purchaseHistoryStore
			return true
		end)
	end)

	if not success then
		error("Failed to process receipt due to data store error.")
		return Enum.ProductPurchaseDecision.NotProcessedYet
	elseif isPurchaseRecorded == nil then

		-- Did not update the value in the data store
		return Enum.ProductPurchaseDecision.NotProcessedYet
	else

		-- IMPORTANT: Tell Roblox that the game successfully handled the purchase
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
end

-- Set the callback; this can only be done once by one script on the server!
MarketplaceService.ProcessReceipt = processReceipt
