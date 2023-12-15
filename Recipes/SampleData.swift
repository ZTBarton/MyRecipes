//
//  SampleData.swift
//  Recipes
//
//  Created by Zach Barton on 12/7/23.
//

import Foundation
import SwiftData

let sampleCategories = [
    RecipeCategory(dateAdded: Date(), lastUsed: Date(), title: "Breakfast"),
    RecipeCategory(dateAdded: Date(), lastUsed: Date(), title: "Lunch"),
    RecipeCategory(dateAdded: Date(), lastUsed: Date(), title: "Dinner"),
    RecipeCategory(dateAdded: Date(), lastUsed: Date(), title: "Appetizer"),
    RecipeCategory(dateAdded: Date(), lastUsed: Date(), title: "Main Course"),
    RecipeCategory(dateAdded: Date(), lastUsed: Date(), title: "Dessert"),
    RecipeCategory(dateAdded: Date(), lastUsed: Date(), title: "Mexican")
]

let sampleRecipes: [SampleRecipe] = [
    SampleRecipe(recipe:
                    Recipe(dateAdded: Date(),
                           lastView: Date(),
                           title: "Buttermilk Pancakes",
                           author: "Sam",
                           recipeDescription: "My BEST Buttermilk pancake recipe makes thick, soft, and SO FLUFFY pancakes that can be ready in under 15 minutes! Recipe includes a how-to video!",
                           categories: [],
                           ingredients: [
                            Ingredient(order: 1, amount: 2.0, unit: "cup", name: "All-Purpose Flour"),
                            Ingredient(order: 2, amount: 3.0, unit: "Tbsp", name: "Sugar"),
                            Ingredient(order: 3, amount: 1.0, unit: "tsp", name: "Baking Powder"),
                            Ingredient(order: 4, amount: 0.5, unit: "tsp", name: "Baking Soda"),
                            Ingredient(order: 5, amount: 0.5, unit: "tsp", name: "Salt"),
                            Ingredient(order: 6, amount: 2.25, unit: "cup", name: "Buttermilk"),
                            Ingredient(order: 7, amount: 2.0, unit: "count", name: "Large eggs"),
                            Ingredient(order: 8, amount: 1.0, unit: "tsp", name: "Vanilla extract"),
                            Ingredient(order: 9, amount: 4.0, unit: "Tbsp", name: "Unsalted butter")
                           ],
                           instructions: [
                            Step(stepNum: 1, title: "Step 1", instruction: "In a large bowl, whisk together flour, sugar, baking powder, baking soda, and salt, until well-combined. "),
                            Step(stepNum: 2, title: "Step 2", instruction: "In a separate, medium-sized bowl, whisk together buttermilk,, eggs, and vanilla extract."),
                            Step(stepNum: 3, title: "Step 3", instruction: "Take your melted butter and slowly drizzle it into your wet ingredients while whisking, stirring until well-combined (the butter may separate and curdle if your other ingredients are cold, this is OK, just whisk to combine)."),
                            Step(stepNum: 4, title: "Step 4", instruction: "Pour wet ingredients into dry ingredients and use a wooden spoon to stir until just combined — do not overmix your pancake batter or your pancakes will be flat.  Use a light hand when stirring, and a few flour streaks in the batter are fine."),
                            Step(stepNum: 5, title: "Step 5", instruction: "Spray a non-stick skillet with cooking spray or lightly brush with canola oil and place on burner on medium-low heat."),
                            Step(stepNum: 6, title: "Step 6", instruction: "Allow skillet to preheat before adding batter (about 5 minutes, it's good for your pancake batter to sit several minutes as well, which is why you prepared that before preheating your pan), and once skillet is heated (I usually test this by hovering my hand several inches above the pan and making sure I can feel the heat radiating from it) scoop pancake batter into pan (I use about ½-⅔ cup of batter per pancake)."),
                            Step(stepNum: 7, title: "Step 7", instruction: "Allow pancake to cook until edges begin to appear cooked and bubbles in batter begin to burst.  Using a pancake spatula, carefully flip pancake and continue to cook several more minutes until pancake is golden brown."),
                            Step(stepNum: 8, title: "Step 8", instruction: "Repeat until all batter is used — I recommend spraying or brushing the pan between each batch of pancakes."),
                            Step(stepNum: 9, title: "Step 9", instruction: "Serve warm topped with salted butter and maple syrup!"),
                           ],
                           timeRequired: 15,
                           servings: 8,
                           difficultyLevel: 3,
                           calories: 243,
                           notes: ["It's best to use real buttermilk."],
                           tags: ["sweet"]
                          ), categories:
                    ["Breakfast"]),
    SampleRecipe(recipe:
                    Recipe(dateAdded: Date(),
                           lastView: Date(),
                           title: "Banana Bread Overnight Oats",
                           author: "Lorie Yarro",
                           recipeDescription: "Just like banana bread straight from the oven, but with barely any effort, these Banana Bread Overnight Oats are breakfast you can wake up to--literally, because they are waiting for you in the morning!",
                           categories: [],
                           ingredients: [
                            Ingredient(order: 1, amount: 0.5, unit: "count", name: "Mashed ripe banana"),
                            Ingredient(order: 2, amount: 0.5, unit: "cup", name: "Rolled oats"),
                            Ingredient(order: 3, amount: 0.5, unit: "cup", name: "Milk of choice"),
                            Ingredient(order: 4, amount: 2.0, unit: "Tbsp", name: "Chopped pecans or walnuts"),
                            Ingredient(order: 5, amount: 1.0, unit: "tsp", name: "Vanilla extract"),
                            Ingredient(order: 6, amount: 0.5, unit: "tsp", name: "Cinnamon"),
                            Ingredient(order: 7, amount: 1.0, unit: "Dash", name: "Sea salt"),
                            Ingredient(order: 8, amount: 1.0, unit: "Tbsp", name: "Ground flax"),
                            Ingredient(order: 9, amount: 2.0, unit: "tsp", name: "100% pure maple syrup")
                           ],
                           instructions: [
                            Step(stepNum: 1, title: "Step 1", instruction: "Mash the banana in the bottom of a bowl or jar that can be sealed. Combine all other ingredients and stir well to combine."),
                            Step(stepNum: 2, title: "Step 2", instruction: "Refrigerate overnight or at least about 4 hours. Serve hot or cold. Garnish with some sliced banana or more nuts if desired.")
                           ],
                           timeRequired: 245,
                           servings: 1,
                           difficultyLevel: 1,
                           calories: 387,
                           notes: ["Can be served hot or cold.", "Adjust sweetness as desired."],
                           tags: ["healthy", "easy"]
                          ), categories:
                    ["Breakfast"]),
    SampleRecipe(recipe:
                    Recipe(dateAdded: Date(),
                           lastView: Date(),
                           title: "Garlic Butter Steak Bites",
                           author: "Nora from Savory Nothings",
                           recipeDescription: "These Garlic Butter Steak Bites are quick and easy to make - and they vanish fast! Serve them as finger food on appetizer night, as part of your game day spread or as part of a fun family dinner date.",
                           categories: [],
                           ingredients: [
                            Ingredient(order: 1, amount: 2.0, unit: "pound", name: "Steak, cut into bites"),
                            Ingredient(order: 2, amount: 1.0, unit: "to taste", name: "Salt and ground black pepper"),
                            Ingredient(order: 3, amount: 1.0, unit: "Tbsp", name: "Oil"),
                            Ingredient(order: 4, amount: 4.0, unit: "Tbsp", name: "Butter"),
                            Ingredient(order: 5, amount: 2.0, unit: "count", name: "Cloves of garlic"),
                            Ingredient(order: 6, amount: 2.0, unit: "Tbsp", name: "Chopped parsley")
                           ],
                           instructions: [
                            Step(stepNum: 1, title: "Step 1", instruction: "Remove steak from fridge 30 minutes before cooking. Unwrap, cut into cubes and season with salt and pepper. Let sit on plate on counter for 30 minutes."),
                            Step(stepNum: 2, title: "Step 2", instruction: "Heat a large skillet over high heat. Add oil, then sear steak for around 2 minutes per side, until a nice, browned crust forms but middle stays tender. Work in batches if needed, do not overcrowd pan. Set seared steak bites aside on a plate and tent with foil."),
                            Step(stepNum: 3, title: "Step 3", instruction: "Once steak is done and set aside on a plate, reduce heat to medium. Add butter and garlic to empty skillet. Heat about 2 minutes, until garlic is fragrant. Take off the heat."),
                            Step(stepNum: 4, title: "Step 4", instruction: "Add steak to skillet with garlic butter. Toss to coat. Serve immediately with chopped parsley, if desired.")
                           ],
                           timeRequired: 40,
                           servings: 8,
                           difficultyLevel: 1,
                           calories: nil,
                           notes: ["Best served as finger food or part of a family dinner.", "Adjust garlic quantity to taste."],
                           tags: ["quick", "easy", "appetizer"]
                          ), categories:
                    ["Appetizer", "Main Course", "Dinner"]),
    SampleRecipe(recipe:
                    Recipe(dateAdded: Date(),
                           lastView: Date(),
                           title: "Turkey Bacon Avocado Sandwich",
                           author: "Julie Maestre",
                           recipeDescription: "This quick and easy turkey sandwich is the ultimate sandwich! Hands down the best sandwich you'll ever eat.",
                           categories: [],
                           ingredients: [
                            Ingredient(order: 1, amount: 6.0, unit: "slices", name: "Turkey"),
                            Ingredient(order: 2, amount: 2.0, unit: "slices", name: "Provolone cheese"),
                            Ingredient(order: 3, amount: 4.0, unit: "count", name: "Strips of crispy bacon"),
                            Ingredient(order: 4, amount: 2.0, unit: "slices", name: "Salted tomatoes"),
                            Ingredient(order: 5, amount: 0.5, unit: "count", name: "Avocado, sliced"),
                            Ingredient(order: 6, amount: 2.0, unit: "Tbsp", name: "Chipotle mayo"),
                            Ingredient(order: 7, amount: 1.0, unit: "count", name: "Ciabatta bread"),
                            Ingredient(order: 8, amount: 0.25, unit: "cup", name: "Mayo"),
                            Ingredient(order: 9, amount: 0.5, unit: "Tbsp", name: "Chipotle sauce"),
                            Ingredient(order: 10, amount: 1.0, unit: "to taste", name: "Salt")
                           ],
                           instructions: [
                            Step(stepNum: 1, title: "Step 1", instruction: "To make the chipotle mayo, mix the mayo and chipotle sauce until smooth."),
                            Step(stepNum: 2, title: "Step 2", instruction: "Cook the bacon over medium heat until fully cooked through and crispy."),
                            Step(stepNum: 3, title: "Step 3", instruction: "Toast the bread until nice and toasty."),
                            Step(stepNum: 4, title: "Step 4", instruction: "Add about 1-2 tbsp of chipotle mayo to the bread. Place the crispy bacon, salted tomatoes, avocado, provolone cheese, and sliced turkey on top of the ciabatta bread and top it off with the second piece of ciabatta bread.")
                           ],
                           timeRequired: 25,
                           servings: 2,
                           difficultyLevel: 1,
                           calories: 1203,
                           notes: ["Customize with your favorite condiments and toppings."],
                           tags: ["sandwich", "easy", "quick"]
                          ), categories:
                    ["Main Entree", "Lunch"]),
    SampleRecipe(recipe:
                    Recipe(dateAdded: Date(),
                           lastView: Date(),
                           title: "Chicken Burrito Protein Bowl",
                           author: "Yumna Jawad",
                           recipeDescription: "Chipotle-inspired, this Chicken Burrito Protein Bowl is bursting with color, flavor, and nutrients. It's a chicken bowl recipe that is easily customizable!",
                           categories: [],
                           ingredients: [
                            // For the chicken
                            Ingredient(order: 1, amount: 0.25, unit: "cup", name: "Avocado oil"),
                            Ingredient(order: 2, amount: 3.0, unit: "Tbsp", name: "Lime juice"),
                            Ingredient(order: 3, amount: 3.0, unit: "count", name: "Chipotle chilis in adobo sauce, finely chopped"),
                            Ingredient(order: 4, amount: 1.5, unit: "Tbsp", name: "Adobo sauce"),
                            Ingredient(order: 5, amount: 1.5, unit: "tsp", name: "Garlic powder"),
                            Ingredient(order: 6, amount: 0.75, unit: "tsp", name: "Salt"),
                            Ingredient(order: 7, amount: 1.5, unit: "pound", name: "Chicken breast, cut into strips"),
                            // For the cilantro lime rice
                            Ingredient(order: 8, amount: 1.0, unit: "cup", name: "Long-grain white rice, rinsed"),
                            Ingredient(order: 9, amount: 1.5, unit: "cup", name: "Water"),
                            Ingredient(order: 10, amount: 0.25, unit: "tsp", name: "Salt"),
                            Ingredient(order: 11, amount: 1.0, unit: "count", name: "Zest of 1 lime"),
                            Ingredient(order: 12, amount: 2.0, unit: "Tbsp", name: "Fresh lime juice"),
                            Ingredient(order: 13, amount: 0.25, unit: "cup", name: "Chopped fresh cilantro"),
                            // To assemble
                            Ingredient(order: 14, amount: 1.0, unit: "count", name: "Head of romaine lettuce, chopped"),
                            Ingredient(order: 15, amount: 1.0, unit: "cup", name: "Diced tomatoes"),
                            Ingredient(order: 16, amount: 1.0, unit: "count", name: "Avocado, chopped"),
                            Ingredient(order: 17, amount: 1.0, unit: "cup", name: "Frozen corn, thawed"),
                            Ingredient(order: 18, amount: 1.0, unit: "can", name: "Black beans, rinsed and drained"),
                            Ingredient(order: 19, amount: 0.5, unit: "count", name: "Small red onions, chopped")
                           ],
                           instructions: [
                            Step(stepNum: 1, title: "Step 1", instruction: "Stir together oil, lime juice, chopped chilies, adobo sauce, garlic powder, and salt in a large bowl. Add chicken and toss to coat. Cover and let sit in the refrigerator for at least 2 hours or up to overnight."),
                            Step(stepNum: 2, title: "Step 2", instruction: "Heat a large pan over medium-high heat. Remove chicken from marinade, and add to pan. Cook, stirring, until cooked through, about 5 minutes. Set aside."),
                            Step(stepNum: 3, title: "Step 3", instruction: "Add salt and rice to a pot of boiling water. Return to a boil, then reduce heat, cover, and simmer until water is absorbed and rice is tender, 15-18 minutes. Uncover and fluff with a fork, then toss in lime zest, lime juice, cilantro, and additional salt to taste."),
                            Step(stepNum: 4, title: "Step 4", instruction: "Arrange rice and lettuce in the bottom of a serving bowl and top with the chicken, diced tomatoes, diced avocados, corn, black beans, and red onions.")
                           ],
                           timeRequired: 170,
                           servings: 4,
                           difficultyLevel: 2,
                           calories: 768,
                           notes: ["Marinate chicken for at least 2 hours for best flavor.", "Customize with your choice of toppings."],
                           tags: ["protein", "Mexican", "healthy"]
                          ), categories:
                    ["Main Course", "Mexican"])
]

struct SampleRecipe {
    var recipe: Recipe
    var categories: [String]
}
