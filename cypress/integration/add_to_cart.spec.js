describe("Add to cart", () => {
  it("Visit the home page", () => {
    cy.visit('/');
  });

  it("Verify that the count of the cart button is 0", () => {
    cy.get('a[href="/cart"]')
      .contains(" My Cart (0)");
  });

  it("Click the add button for the scented blade product", () => {
    cy.contains("Add")
      .click({ force: true });
  });

  it("Verify that the count of the cart button changes to 1", () => {
    cy.get('a[href="/cart"]')
      .contains(" My Cart (1)");
  });
});